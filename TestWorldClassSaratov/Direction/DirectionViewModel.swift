import Foundation
import Observation

// MARK: - DirectionViewModel
@Observable final class DirectionViewModel {
    
    // MARK: - Properties
    let directions: [DirectionType] = DirectionType.allCases
    var selectedDirection: DirectionType?
    var isLoading = false
    var error: String?
    
    // MARK: - Computed Properties
    var hasSelectedDirection: Bool {
        selectedDirection != nil
    }
    
    // MARK: - Public Methods
    func selectDirection(_ direction: DirectionType) {
        selectedDirection = direction
    }
    
    func clearSelection() {
        selectedDirection = nil
    }
    
    func getDirection(by type: DirectionType) -> DirectionType? {
        return directions.first { $0 == type }
    }
} 
