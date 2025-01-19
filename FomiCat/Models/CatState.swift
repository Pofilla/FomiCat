import Foundation

class CatState: ObservableObject {
    @Published var hunger: Double = 0.5 // 0 = full, 1 = hungry
    @Published var mood: Double = 0.7 // 0 = unhappy, 1 = very happy
    @Published var energy: Double = 1.0 // 0 = tired, 1 = energetic
    @Published var isAsleep: Bool = false
    
    // Time tracking
    private var lastInteractionTime: Date = Date()
    
    // State ranges
    static let moodThresholds = (
        unhappy: 0.3,
        neutral: 0.6,
        happy: 0.8
    )
    
    static let hungerThresholds = (
        full: 0.2,
        satisfied: 0.5,
        hungry: 0.8
    )
    
    func updateState() {
        let timeSinceLastInteraction = Date().timeIntervalSince(lastInteractionTime)
        
        // Gradually increase hunger and decrease mood over time
        if !isAsleep {
            hunger = min(1.0, hunger + timeSinceLastInteraction / 3600) // Increase hunger over an hour
            mood = max(0.0, mood - timeSinceLastInteraction / 7200) // Decrease mood over two hours
            energy = max(0.0, energy - timeSinceLastInteraction / 14400) // Decrease energy over four hours
        } else {
            // Recover energy while sleeping
            energy = min(1.0, energy + timeSinceLastInteraction / 1800) // Recover energy over 30 minutes
        }
        
        lastInteractionTime = Date()
    }
} 