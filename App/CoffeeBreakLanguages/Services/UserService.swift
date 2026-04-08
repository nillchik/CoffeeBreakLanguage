

import Foundation


@Observable
class UserService {
    
    var isPremium = false
    var lessonProgress: [String : Double] = [:]
    
    init() {
        
        if let saved = UserDefaults.standard.dictionary(forKey: "lessonProgress") as? [String: Double] {
            lessonProgress = saved
        }
    }
    
    func saveProgress(lessonID: String, progress: Double) {
        lessonProgress[lessonID] = progress
        UserDefaults.standard.set(lessonProgress, forKey: "\(lessonID)")
        
        
        
    }
    
    func getProgress(lessonID: String) -> Double {
        
        
        return lessonProgress[lessonID] ?? 0.0
    }
        
    
}


