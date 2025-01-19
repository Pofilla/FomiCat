import SwiftUI

struct PlayView: View {
    @ObservedObject var catState: CatState
    @State private var toyPosition: CGPoint = .zero
    @State private var catPosition: CGPoint = .zero
    @State private var isPlaying = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Play area background
                Color.clear
                
                // Toy (feather or ball)
                Image(systemName: "star.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(.yellow)
                    .position(toyPosition)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                toyPosition = value.location
                                updateCatPosition(geometry: geometry)
                                if !isPlaying {
                                    startPlaying()
                                }
                            }
                    )
                
                // Cat
                Image(systemName: "cat.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.black)
                    .position(catPosition)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: catPosition)
            }
            .onAppear {
                // Initialize positions
                toyPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                catPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height * 0.7)
            }
        }
    }
    
    private func updateCatPosition(geometry: GeometryProxy) {
        guard !catState.isAsleep else { return }
        
        // Calculate distance between cat and toy
        let dx = toyPosition.x - catPosition.x
        let dy = toyPosition.y - catPosition.y
        let distance = sqrt(dx * dx + dy * dy)
        
        // Move cat towards toy, but not exactly to it
        let catchDistance: CGFloat = 60
        if distance > catchDistance {
            let factor: CGFloat = 0.3
            catPosition.x += dx * factor
            catPosition.y += dy * factor
        }
    }
    
    private func startPlaying() {
        isPlaying = true
        catState.energy = max(0, catState.energy - 0.1)
        catState.mood = min(1, catState.mood + 0.2)
        
        // Reset playing state after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isPlaying = false
        }
    }
} 