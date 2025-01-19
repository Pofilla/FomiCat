import SwiftUI

struct FeedView: View {
    @ObservedObject var catState: CatState
    @State private var selectedFood: FoodType?
    @State private var showingFeedAnimation = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Feed Your Cat")
                .font(.title)
                .padding()
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(FoodType.allCases) { food in
                    FoodItemView(
                        food: food,
                        isSelected: selectedFood == food
                    )
                    .onTapGesture {
                        feedCat(with: food)
                    }
                }
            }
            .padding()
            
            if showingFeedAnimation {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
                    .font(.largeTitle)
                    .transition(.scale.combined(with: .opacity))
            }
            
            Spacer()
        }
    }
    
    private func feedCat(with food: FoodType) {
        guard !catState.isAsleep else { return }
        
        selectedFood = food
        catState.hunger = max(0, catState.hunger - food.hungerReduction)
        catState.mood = min(1, catState.mood + food.moodBoost)
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            showingFeedAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                showingFeedAnimation = false
            }
        }
    }
}

struct FoodItemView: View {
    let food: FoodType
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: food.imageName)
                .font(.system(size: 40))
                .foregroundStyle(isSelected ? .green : .primary)
            
            Text(food.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
                .shadow(radius: 2)
        )
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
} 