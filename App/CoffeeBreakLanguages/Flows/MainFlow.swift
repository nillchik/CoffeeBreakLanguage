
import SwiftUI

struct MainFlow: View {
    @State private var currentTab: MenuButtons = .home
    @State private var exploreService = ExploreService()
    @State private var userService = UserService()
    @State private var player = AudioEngine()
    var body: some View {
        
        VStack(spacing: 0) {
            
            TabView(selection: $currentTab) {
                
                CourseSelectingScreen()
                    .tag(MenuButtons.home)
                ExploreScreen()
                    .tag(MenuButtons.explore)
                    
                SettingsScreen()
                    .tag(MenuButtons.settings)
                
                
            } .toolbarVisibility(.hidden, for: .tabBar)
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            MenuPanel(currentTab: $currentTab)
                
            
        }
        .environment(exploreService)
        .environment(userService)
        .environment(player)
            
            
           
    }
}

#Preview {
    MainFlow()
}

//MARK: MENU PANEL IN SAFEAREA
private struct MenuPanel: View {
    @Binding var currentTab: MenuButtons
    var body: some View {
        
        HStack(spacing: 0) {
            
            ForEach(MenuButtons.allCases) { button in
                
                Button(action: {
                    withAnimation {
                        currentTab = button
                    }
                    
                }) {
                    
                    VStack(spacing: 3) {
                        
                        Image(systemName: button.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30)
                            .tabBarCurrentTab(isCurrentTab: currentTab == button)
                            
                        Text(button.title)
                            
                        
                    } .foregroundColor(currentTab == button ? .mainGreen : .gray)
                    
                    
                }
                    
                
            } .frame(maxWidth: .infinity)
                .ignoresSafeArea()
            .padding(.top, 10)
            
            
        }
        .padding(.bottom, 20)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(Color.black.opacity(0.8))
                .mask(RoundedRectangle(cornerRadius: 0))
            
                
        }
       
            
        
    }
    
    
}
