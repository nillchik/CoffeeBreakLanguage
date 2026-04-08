
import Foundation
import Firebase
import FirebaseFirestore

enum LessonsComplexity: String, CaseIterable, Identifiable, Codable {
    
    case beginner = "beginner"
    case intermediate = "intermediate"
    case advanced = "advanced"
    
    
    var id: String { rawValue }
    
    
    var subTitle: String {
        
        switch self {
    
            
            
        case .beginner:
            "Start your journey"
        case .intermediate:
            "Build your confidence"
        case .advanced:
            "Master the language"
        }
        
    }
    
    var description: String {
        
        switch self {
            
            
        case .beginner:
            "Perfect for those just starting out. Learn basic vocabulary, grammar, and essential phrases."
        case .intermediate:
            "Expand your vocabulary and improve conversational skills. Great for everyday communication."
        case .advanced:
            "Deepen your understanding of complex structures, idioms, and native-like expression."
        }
        
    }
    
    
}

struct Course: Hashable, Identifiable, Codable  {
    
    @DocumentID var id: String?
    let countryName: String
    
    
}

struct LessonsDescription: Identifiable, Hashable, Codable {
    var id: Int { order }
    let title: String
    let order: Int
    let audioURL: String
}

struct CourseLevel: Identifiable, Codable {
    
    @DocumentID var id: String?
    let complexity: LessonsComplexity
    
    let lessons: [LessonsDescription]
    
    var lessonsCount: String {
        if lessons.count > 1 {
            return String(lessons.count) + " lessons"
        } else {
            return String(lessons.count) + " lesson"
        }
        
        
    }
    
    
    
}
