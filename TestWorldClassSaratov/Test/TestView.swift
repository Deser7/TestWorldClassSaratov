import SwiftUI

// MARK: - ContentView
struct TestView: View {
    // MARK: - Properties
    @State var viewModel: TestViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Group {
                // MARK: - Loading State
                if viewModel.isLoading {
                    ProgressView("Загрузка теста...")
                        .font(.headline)
                    // MARK: - Error State
                } else if let error = viewModel.error {
                    VStack {
                        Text("Ошибка")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(error)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundStyle(.primary)
                        Button("Попробовать снова") {
                            viewModel.resetTest()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    
                }
                // MARK: - Test Completed State
                else if viewModel.testCompleted {
                    let correctAnswers = viewModel.userAnswers.compactMap { questionIndex, answerIndex in
                        guard questionIndex < viewModel.questions.count else { return nil }
                        return viewModel.questions[questionIndex].correctAnswerIndex == answerIndex ? 1 : 0
                    }.reduce(0, +)
                    
                    let resultViewModel = ResultViewModel(
                        score: viewModel.score,
                        totalQuestions: viewModel.questions.count,
                        correctAnswers: correctAnswers,
                        directionName: getDirectionName(),
                        timeSpent: TestConfiguration.TimeLimits.timeLimit(for: viewModel.directionType) - viewModel.remainingTime
                    )
                    
                    ResultView(viewModel: resultViewModel) {
                        dismiss()
                    }
                }
                // MARK: - Question State
                else if let question = viewModel.currentQuestion {
                    QuestionView(
                        question: question,
                        selectedAnswerIndex: viewModel.userAnswers[viewModel.currentQuestionIndex],
                        onAnswerSelected: { index in
                            viewModel.selectAnswer(index)
                        },
                        onNext: {
                            viewModel.nextQuestion()
                        },
                        onPrevious: {
                            viewModel.previousQuestion()
                        },
                        isLastQuestion: viewModel.isLastQuestion,
                        isFirstQuestion: viewModel.currentQuestionIndex == 0,
                        progress: viewModel.progress
                    )
                }
            }
            // MARK: - Navigation Bar
            .navigationTitle("Тест")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: - Exit Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Выйти") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
                
                // MARK: - Timer
                ToolbarItem(placement: .principal) {
                    TimerView(
                        remainingTime: viewModel.remainingTime,
                        isVisible: !viewModel.isLoading && !viewModel.testCompleted
                    )
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func getDirectionName() -> String {
        return FitnessDirection.direction(for: viewModel.directionType)?.name ?? "Неизвестное направление"
    }
}

#Preview {
    TestView(viewModel: TestViewModel(directionType: .gym))
}
