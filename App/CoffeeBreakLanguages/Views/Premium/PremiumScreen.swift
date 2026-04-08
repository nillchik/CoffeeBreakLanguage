
import SwiftUI

struct PremiumScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = PremiumScreenViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        Header()
                        BuyPanel()
                        PremiumFeatures()
                        BuyButton()
                        LegalDocumentView()
                    } .padding(.horizontal, 20)
                } .contentMargins(.top, 50, for: .scrollContent)
                .contentMargins(.bottom, 50, for: .scrollContent)
            } .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                
                .environment(viewModel)
                .background(Color.black)
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        
                        Button(action: {
                            
                            dismiss()
                            
                            
                        }) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                            
                        }
                        
                    }
                    
                    
                }
        }
    }
}

#Preview {
    PremiumScreen()
}


private struct Header: View {
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            
            PremiumImageOrder()
            Text("Unlock Premium")
                .font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("Supercharge your language learning journey with unlimited access")
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundColor(.mainAsh)
            
            
            
        } .frame(maxWidth: .infinity)
        
        
        
    }
    
    
}


private struct PremiumImageOrder: View {
    
    var body: some View {
        
        Image(systemName: "crown")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.mainGreen)
            .frame(maxWidth: 60, maxHeight: 60)
            .foregroundColor(.mainAsh)
            .padding(20)
            .background {
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(.emerald.opacity(0.6))
                    .stroke(Color.mainGreen, lineWidth: 1)
                
                
            }
        
        
        
    }
    
    
}


private struct BuyRectangle: View {
    let plan: SubscriptionPlan
    @Environment(PremiumScreenViewModel.self) var viewModel
    var body: some View {
        
            
            HStack(spacing: 5) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .bottom, spacing: 10) {
                        
                        Text(plan.price)
                            .font(.title)
                            .foregroundColor(.white)
                        Text(plan.period)
                            .font(.callout)
                            .foregroundColor(.mainAsh)
                        
                    }
                    
                    Text(plan.rawValue)
                        .foregroundColor(.mainAsh)
                        .font(.subheadline)
                    if let convenience = plan.convenience {
                        Text(convenience)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.mainGreen)
                    }
                }
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(viewModel.rectangle.id == plan.id ? Color.mainGreen : .black)
                        .stroke(Color.mainAsh, lineWidth: 1)
                        .frame(maxWidth: 25, maxHeight: 25)
                    Circle()
                        .fill(.black)
                        .frame(maxWidth: 10, maxHeight: 10)
                }
                
            } .frame(maxWidth: .infinity)
            
            
            
            
            .padding(20)
            
            
            .background {

                RoundedRectangle(cornerRadius: 20)
                    .fill(viewModel.rectangle.id == plan.id ? .emerald.opacity(0.5) : .card)
                
                    .stroke(Color.mainGreen, lineWidth: viewModel.rectangle.id == plan.id ? 3 : 0)
                    
                
                
            } .onTapGesture {
                withAnimation {
                    viewModel.rectangleTap(onRectangle: plan)
                }
            }
            
            
            
        
        
    }
    
    
}

private struct BuyPanel: View {
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            ForEach(SubscriptionPlan.allCases, id: \.self) { plan in
                
                BuyRectangle(plan: plan)
                
                
                
            }
            
            
            
            
        }
        
        
        
        
    }
    
    
}




private struct PremiumFeatures: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Premium Features")
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .font(.title2)
                .fontWeight(.bold)
            VStack(alignment: .leading, spacing: 10) {
                
                ForEach(premiumFeatures, id: \.self) { feature in
                    
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 15, maxHeight: 15)
                            .foregroundColor(.mainGreen)
                            
                        Text(feature)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.white)
                        
                    }

                }
                
                
            }
            
            
            
        } .makeMainCard()
        
        
        
    }
    
    
}

private struct BuyButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        Button(action: {
            
            dismiss()
            
        }) {
            
            Text("Buy Now")
                .foregroundColor(.black)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.mainGreen)
                .cornerRadius(20)
            
            
        } .shadow(color: .mainGreen, radius: 20)
        
    }
    
    
    
}

private struct LegalDocumentButton: View {
    let title: String
    var body: some View {
        
        Button(action: {
            
            //MARK: ADD URL REQUEST AND ADD URL IN ENUM
            
            
        }) {
            
            
            HStack(spacing: 0) {
                
                Text(title)
                
            }
            
            
            
        }
        
        
    }
    
    
}



private struct LegalDocumentView: View {
    var body: some View {
        
        HStack(spacing: 0) {
            
            ForEach(Array(LegalDocument.allCases.enumerated()), id: \.offset) { index, document in
                Text(document.title)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .foregroundColor(.mainAsh)
                    .font(.headline)
                if index != LegalDocument.allCases.count - 1 {
                    
                    Circle()
                        .fill(Color.mainAsh)
                        .frame(maxWidth: 5, maxHeight: 5)
                    
                    
                }
                
            } .frame(maxWidth: .infinity)
            
            
        }
        
        
    }
}
