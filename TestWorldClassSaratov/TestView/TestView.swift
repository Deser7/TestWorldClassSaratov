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
                    TestResultView(score: viewModel.score) {
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
                    if !viewModel.isLoading && !viewModel.testCompleted {
                        Text(viewModel.formattedTime)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.remainingTime < 60 ? .red : .primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemBackground))
                                    .shadow(radius: 1)
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    TestView(viewModel: TestViewModel(testFileName: "gym_questions"))
}
