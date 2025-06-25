import Observation
import Foundation

// MARK: - TestViewModel
@Observable final class TestViewModel {
    // MARK: - Properties
    let networkService = NetworkService.shared
    let directionType: DirectionType
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var userAnswers: [Int: Int] = [:]
    var testCompleted = false
    var score = 0
    var isLoading = false
    var error: String?
    var remainingTime: TimeInterval = 0
    
    // MARK: - Computed Properties
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
    
    // MARK: - Initialization
    init(directionType: DirectionType) {
        self.directionType = directionType
        setupTimeLimit()
        Task {
            await loadQuestionsFromAPI()
        }
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
        
        // Перемешиваем вопросы и ответы при сбросе теста, если включено в конфигурации
        if TestConfiguration.Behavior.shuffleQuestionsOnReset {
            shuffleQuestions()
        }
        
        startTimer()
    }
    
    // MARK: - Private Methods
    private func setupTimeLimit() {
        remainingTime = TestConfiguration.TimeLimits.timeLimit(for: directionType)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: TestConfiguration.Timer.interval,
            repeats: true
        ) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= TestConfiguration.Timer.updateFrequency
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
    
    @MainActor
    private func loadQuestionsFromAPI() async {
        isLoading = true
        error = nil
        
        do {
            // Используем удобный метод для получения вопросов по направлению
            questions = try await networkService.fetchQuestions(for: directionType)
            
            // Перемешиваем вопросы и ответы после загрузки, если включено в конфигурации
            if TestConfiguration.Behavior.shuffleQuestionsOnLoad {
                shuffleQuestions()
            }
            
            isLoading = false
        } catch let networkError as NetworkError {
            error = networkError.localizedDescription
            isLoading = false
        } catch let unexpectedError {
            error = "Неожиданная ошибка: \(unexpectedError.localizedDescription)"
            isLoading = false
        }
    }
}
