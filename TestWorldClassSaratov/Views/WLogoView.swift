import SwiftUI

// MARK: - WLogoView
struct WLogoView: View {
    // MARK: - Properties
    @State private var isAnimating = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Background
            Circle()
                .fill(Color.green.opacity(0.1))
                .frame(width: 80, height: 80)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(
                    Animation.easeInOut(duration: 2)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
            
            // MARK: - Logo Text
            Text("W")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .rotationEffect(.degrees(isAnimating ? 5 : -5))
                .animation(
                    Animation.easeInOut(duration: 2)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Preview
#Preview {
    WLogoView()
        .frame(width: 100, height: 100)
        .padding()
} 
 
