
import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                
                dismiss()
                
            }) {
                
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .background {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.card)
                        
                        
                    }
                
            }
        } .padding(.top, 10)
    }
}

#Preview {
    BackButton()
}
