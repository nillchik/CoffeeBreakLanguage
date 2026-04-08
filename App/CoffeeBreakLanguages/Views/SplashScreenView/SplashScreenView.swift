

import SwiftUI

struct SplashScreenView: View {
    @State private var progress: CGFloat = 0
    @State private var isLoaded: Bool = false
    @Environment(CourseService.self) var courseService
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if isLoaded {
                    
                    MainFlow()
                        .transition(.opacity.combined(with: .scale(scale: 0.8)))
                    
                } else {
                    
                    VStack(alignment: .center, spacing: 20) {
                        Image("progressBarIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 250)
                        Text("CoffeeBreak")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Master Languages naturally")
                            .foregroundColor(.mainAsh)
                            .fontWeight(.semibold)
                        HStack(spacing: 5) {
                            
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.mainGreen)
                                .frame(maxHeight: 5)
                            Text("Premium Language Learning")
                                .foregroundColor(.mainGray)
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.mainGreen)
                                .frame(maxHeight: 5)
                            
                            
                        }
                        AppProgressBar(progress: progress)
                        HStack(spacing: 5) {
                            Text("Loading")
                                .foregroundColor(.mainGray)
                            Text("\(Int(progress*100))%")
                                .foregroundColor(.mainGreen)
                                .animation(.linear(duration: 0.4), value: progress)
                        }
                        
                        
                        
                    } .padding(.horizontal, 20)
                    
                    
                    
                }
                
                
            } .animation(.easeInOut(duration: 0.6), value: isLoaded)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .task {
                
                await startApp()
                
            }
        }
           
        
    }
    @MainActor
    private func startApp() async {
        
            progress = 0.1
        try? await Task.sleep(for: .seconds(0.5))
            progress = 0.4
            await courseService.fetchCourse()
        try? await Task.sleep(for: .seconds(0.8))
            progress = 0.6
        try? await Task.sleep(for: .seconds(0.4))
            progress = 1
        try? await Task.sleep(for: .seconds(0.4))
            isLoaded = true
    }
}

#Preview {
    let courseService = CourseService()
    SplashScreenView()
        .environment(courseService)
}
