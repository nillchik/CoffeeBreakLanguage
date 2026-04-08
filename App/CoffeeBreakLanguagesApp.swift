
import SwiftUI
import Firebase
@main

struct CoffeeBreakLanguagesApp: App {
    @State private var courseService: CourseService
    init () {
        
        FirebaseApp.configure()
        _courseService = State(initialValue: CourseService())
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(courseService)
               
        }
    }
}
