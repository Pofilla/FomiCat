import Foundation

enum FoodType: String, CaseIterable, Identifiable {
    case kibble
    case fish
    case treat
    case milk
    
    var id: String { rawValue }
    
    var hungerReduction: Double {
        switch self {
        case .kibble: return 0.3
        case .fish: return 0.5
        case .treat: return 0.1
        case .milk: return 0.2
        }
    }
    
    var moodBoost: Double {
        switch self {
        case .kibble: return 0.1
        case .fish: return 0.3
        case .treat: return 0.4
        case .milk: return 0.2
        }
    }
    
    var imageName: String {
        switch self {
        case .kibble: return "bowl.fill"
        case .fish: return "fish.fill"
        case .treat: return "star.fill"
        case .milk: return "drop.fill"
        }
    }
} 