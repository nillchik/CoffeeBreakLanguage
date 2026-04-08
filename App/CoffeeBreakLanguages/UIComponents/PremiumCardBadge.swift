

import SwiftUI

struct PremiumCardBadge: View {
    
    var body: some View {
        
            HStack(spacing: 5) {
                Image(systemName: "crown")
                    .foregroundColor(.yellow)
                Text("Premium")
                    .font(.caption2)
                    .fontWeight(.bold)
            } .padding(.horizontal, 5)
            .padding(.vertical, 5)
            .foregroundColor(.yellow)
            .background {
                Capsule()
                    .fill(.yellow.opacity(0.4))
                    
            } .overlay {
                
                Capsule()
                    .stroke(Color.premiumGold, lineWidth: 1)
                
                
            }
            
    }
}

#Preview {
    PremiumCardBadge()
}
