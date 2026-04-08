

import SwiftUI

struct AppProgressBar: View {
    var progress: CGFloat
    var body: some View {
        GeometryReader { geo in
                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.mainAsh.opacity(0.2))
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.mainGreen)
                        .frame(width: geo.size.width * progress)
                    
                }
                
                
            } .frame(height: 12)
            .animation(.easeInOut, value: progress)
        }
    }

#Preview {
    AppProgressBar(progress: 0)
}
