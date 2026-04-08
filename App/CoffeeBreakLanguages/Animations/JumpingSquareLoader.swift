
import SwiftUI

struct JumpingSquareLoader: View {
    @State private var shifts: [CGFloat] = [0, 0, 0]
    let colors: [Color] = [.mainGreen, .accentGreen, .white.opacity(0.5)]
    var body: some View {
        HStack(spacing: 8) {
            
            ForEach(0..<3, id: \.self) { index in
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(colors[index])
                    .frame(width: 12, height: 12)
                    .offset(y: shifts[index])
                
            }
            
        } .onAppear {
            
            animateSquare()
            
        }
        
        
    }
    private func animateSquare() {
        
        for i in 0..<3 {
            
            Task {
                
                try? await Task.sleep(for: .seconds(Double(i) * 0.15))
                await MainActor.run {
                    
                    withAnimation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                        
                        shifts[i] = -15
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        
        
    }
}





#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        JumpingSquareLoader()
    }
}
