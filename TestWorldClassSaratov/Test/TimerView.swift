import SwiftUI

// MARK: - TimerView
struct TimerView: View {
    // MARK: - Properties
    let remainingTime: TimeInterval
    let isVisible: Bool
    
    // MARK: - Computed Properties
    private var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private var timerColor: Color {
        remainingTime < 60 ? .red : .primary
    }
    
    // MARK: - Body
    var body: some View {
        if isVisible {
            Text(formattedTime)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(timerColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 1)
                )
                .animation(.easeInOut(duration: 0.3), value: remainingTime)
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        TimerView(remainingTime: 1200, isVisible: true) // 20 минут
        TimerView(remainingTime: 45, isVisible: true)   // 45 секунд (красный)
        TimerView(remainingTime: 600, isVisible: false) // скрытый
    }
    .padding()
} 