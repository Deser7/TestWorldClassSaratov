import Foundation
import Observation

// MARK: - DirectionViewModel
@Observable final class DirectionViewModel {
    
    // MARK: - Properties
    let directions: [FitnessDirection] = FitnessDirection.directions
    var selectedDirection: FitnessDirection?
    var isLoading = false
    var error: String?
    
    // MARK: - Computed Properties
    var hasSelectedDirection: Bool {
        selectedDirection != nil
    }
    
    // MARK: - Public Methods
    func selectDirection(_ direction: FitnessDirection) {
        selectedDirection = direction
    }
    
    func clearSelection() {
        selectedDirection = nil
    }
    
    func getDirection(by type: DirectionType) -> FitnessDirection? {
        return directions.first { $0.type == type }
    }
} 
