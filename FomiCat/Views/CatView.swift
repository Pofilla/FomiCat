import SwiftUI

struct CatView: View {
    @ObservedObject var catState: CatState
    @State private var catScale: CGFloat = 1.0
    @State private var catRotation: Angle = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Status indicators
                HStack(spacing: 20) {
                    StatusIndicator(
                        value: catState.hunger,
                        icon: "bowl.fill",
                        color: .orange
                    )
                    StatusIndicator(
                        value: catState.mood,
                        icon: "heart.fill",
                        color: .red
                    )
                    StatusIndicator(
                        value: catState.energy,
                        icon: "bolt.fill",
                        color: .yellow
                    )
                }
                .padding()
                
                Spacer()
                
                // Cat image
                Image(systemName: catState.isAsleep ? "cat.circle.fill" : "cat.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.6)
                    .foregroundStyle(catState.isAsleep ? .gray : .black)
                    .scaleEffect(catScale)
                    .rotationEffect(catRotation)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    catScale = 1.1
                                }
                            }
                            .onEnded { _ in
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    catScale = 1.0
                                    catState.mood = min(1.0, catState.mood + 0.1)
                                }
                            }
                    )
                
                Spacer()
            }
        }
    }
}

struct StatusIndicator: View {
    let value: Double
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundStyle(color)
            ProgressView(value: value)
                .tint(color)
                .frame(width: 60)
        }
    }
} 