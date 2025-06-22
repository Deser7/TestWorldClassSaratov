import Observation
import Foundation

// MARK: - TestViewModel
@Observable final class TestViewModel {
    // MARK: - Properties
    let networkService = NetworkService.shared
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var userAnswers: [Int: Int] = [:]
    var testCompleted = false
    var score = 0
    var isLoading = false
    var error: String?
    var remainingTime: TimeInterval = 0
    
    // MARK: - Computed Properties
    var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var progress: Double {
        Double(currentQuestionIndex) / Double(questions.count)
    }
    
    var isLastQuestion: Bool {
        currentQuestionIndex == questions.count - 1
    }
    
    // MARK: - Private Properties
    private var timer: Timer?
    private let testFileName: String
    
    // MARK: - Initialization
    init(testFileName: String) {
        self.testFileName = testFileName
        setupTimeLimit()
        loadQuestions()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Public Methods
    func selectAnswer(_ answerIndex: Int) {
        userAnswers[currentQuestionIndex] = answerIndex
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            completeTest()
        }
    }
    
    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }
    
    func resetTest() {
        currentQuestionIndex = 0
        userAnswers.removeAll()
        testCompleted = false
        score = 0
        setupTimeLimit()
        shuffleQuestions() // Перемешиваем вопросы и ответы при сбросе теста
        startTimer()
    }
    
    // MARK: - Private Methods
    private func setupTimeLimit() {
        switch testFileName {
        case "general_questions":
            remainingTime = 30 * 60 // 30 минут
        case "manager_questions":
            remainingTime = 10 * 60 // 10 минут
        default:
            remainingTime = 20 * 60 // 20 минут по умолчанию
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.completeTest()
            }
        }
    }
    
    private func completeTest() {
        timer?.invalidate()
        timer = nil
        calculateScore()
        testCompleted = true
    }
    
    private func calculateScore() {
        var correctAnswers = 0
        for (index, answer) in userAnswers {
            if questions[index].correctAnswerIndex == answer {
                correctAnswers += 1
            }
        }
        score = Int((Double(correctAnswers) / Double(questions.count)) * 100)
    }
    
    private func shuffleQuestions() {
        // Перемешиваем вопросы
        questions.shuffle()
        
        // Перемешиваем ответы для каждого вопроса
        for index in 0..<questions.count {
            var answers = questions[index].answers
            let correctAnswer = answers[questions[index].correctAnswerIndex]
            
            // Перемешиваем ответы
            answers.shuffle()
            
            // Находим новый индекс правильного ответа
            if let newCorrectIndex = answers.firstIndex(of: correctAnswer) {
                questions[index].correctAnswerIndex = newCorrectIndex
                questions[index].answers = answers
            }
        }
    }
    
    private func loadQuestions() {
        isLoading = true
        error = nil
        
        guard let url = Bundle.main.url(forResource: testFileName, withExtension: "json") else {
            error = "Не удалось найти файл с тестом"
            isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            questions = try decoder.decode([Question].self, from: data)
            shuffleQuestions() // Перемешиваем вопросы и ответы после загрузки
            isLoading = false
        } catch {
            self.error = "Ошибка загрузки теста: \(error.localizedDescription)"
            isLoading = false
        }
    }
    
    private func loadQuestionsNetwork() {
        isLoading = true
        error = nil
        
        
    }
}
