

import Foundation
import Firebase
import FirebaseFirestore

enum ScreenState {
    
    case loading
    case success
    case error
    
}


@Observable
@MainActor
class ExploreViewModel {
    
    var state: ScreenState = .loading
    var showCountryLesson: Bool = false
    var showLearningPathLesson: Bool = false
    func fetchAllData(exploreService: ExploreService) async {
        state = .loading
        
        let success = await withTaskGroup(of: Bool.self) { group in
            
            group.addTask {
                
                async let a: () = exploreService.fetchCountries()
                async let b: () = exploreService.fetchFeaturedCountry()
                async let c: () = exploreService.fetchLearningPath()
                    _ = await (a, b, c)
                return true
                
                
            }
            
            group.addTask {
                
                
                try? await Task.sleep(for: .seconds(5))
                return false
                
            }
            
            if let result = await group.next() {
                group.cancelAll()
                return result
                
            }
            
            return false
            
            
            
        }
        
        await MainActor.run {
            
            self.state = success ? .success : .error
            
        }
        
        
    }
    
    func openCountryLessons() {
        
        showCountryLesson = true
        
        
    }
    
    func openLearningPathLesson() {
        
        showLearningPathLesson = true
        
        
    }
    
}
