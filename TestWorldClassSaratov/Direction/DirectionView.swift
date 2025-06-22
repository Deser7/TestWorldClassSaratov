import SwiftUI

// MARK: - DirectionSelectionView
struct DirectionView: View {
    // MARK: - Properties
    @State private var selectedDirection: DirectionViewModel?
    @State private var showingTest = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // MARK: - Logo
                    WLogoView()
                        .frame(height: 100)
                        .padding(.top)
                    
                    // MARK: - Title
                    Text("Выберите направление")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // MARK: - Direction Cards
                    ForEach(DirectionViewModel.directions) { direction in
                        DirectionCardView(
                            direction: direction,
                            isSelected: selectedDirection?.id == direction.id
                        ) {
                            withAnimation {
                                selectedDirection = direction
                            }
                        }
                    }
                    
                    // MARK: - Start Test Button
                    if let selected = selectedDirection {
                        Button(action: { showingTest = true }) {
                            Text("Начать тест по направлению: \(selected.name)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                .padding()
            }
            // MARK: - Navigation
            .navigationTitle("World Class")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showingTest) {
                if let direction = selectedDirection {
                    TestView(viewModel: TestViewModel(testFileName: direction.testFileName))
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    DirectionView()
} 
