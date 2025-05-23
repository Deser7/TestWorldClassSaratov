import Foundation

// MARK: - Question
struct Question: Codable, Identifiable {
    // MARK: - Properties
    let id: Int
    let text: String
    var answers: [String]
    var correctAnswerIndex: Int
    
    // MARK: - Answer State
    var selectedAnswerIndex: Int?
    
    // MARK: - Computed Properties
    var isAnswered: Bool {
        selectedAnswerIndex != nil
    }
    
    var isCorrect: Bool {
        selectedAnswerIndex == correctAnswerIndex
    }
}

// MARK: - TestData
struct TestData: Codable {
    // MARK: - Properties
    let questions: [Question]
} 
