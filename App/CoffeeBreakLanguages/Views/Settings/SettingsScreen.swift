

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    Header()
                    AccountSettingsView()
                    AppSettingsView()
                    SupportSettingsView()
                }
            } .contentMargins(.top, 50, for: .scrollContent)
                .contentMargins(.bottom, 50, for: .scrollContent)
            
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            .background(Color.black)
    }
}

#Preview {
    SettingsScreen()
}


private struct Header: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 10) {
                
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
                    .foregroundColor(.mainGreen)
                
                Text("Settings")
                    .header()
            }
            
            Text("Manage your account and preferences")
                .foregroundColor(.mainAsh)
                .fontWeight(.bold)
            
            
        } .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

private struct SettingsButton: View {
    let title: String
    let description: String
    let icon: String
    let foregroundColor: String
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
                
            Button(action: {
                
                
                
            }) {
                
                HStack(spacing: 10) {
                    
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30, maxHeight: 30)
                        .foregroundColor(Color(from: foregroundColor))
                        .makeSettingsImageOrder()
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(title)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        Text(description)
                            
                            .fontWeight(.bold)
                            .foregroundColor(.mainAsh)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.mainAsh)
                    
                    
                } .makeSettingsCard()
                
                
            }
            
            
        } .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
}

private struct AccountSettingsView: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("ACCOUNT")
                .fontWeight(.medium)
                .foregroundColor(.mainAsh)
            ForEach(AccountSettings.allCases, id: \.self) { item in
                
                SettingsButton(title: item.title, description: item.description, icon: item.icon, foregroundColor: item.color)
                
            }
                
                
            
        }
        
        
    }
    
    
}


private struct AppSettingsView: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("APP SETTINGS")
                .fontWeight(.medium)
                .foregroundColor(.mainAsh)
            ForEach(AppSettings.allCases, id: \.self) { item in
                
                SettingsButton(title: item.title, description: item.description, icon: item.icon, foregroundColor: item.color)
                
                
            }
            
            
        }
        
        
    }
    
    
}


private struct SupportSettingsView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SUPPORT")
                .fontWeight(.medium)
                .foregroundColor(.mainAsh)
            ForEach(SupportSettings.allCases, id: \.self) { item in
                
                SettingsButton(title: item.title, description: item.description, icon: item.icon, foregroundColor: item.color)
                
                
            }
            
            
        }
    }
    
}
