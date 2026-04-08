import Foundation
import Firebase
import FirebaseFirestore

struct LearningPath: Codable, Hashable {
    
    @DocumentID var id: String?
    let icon: String
    let title: String
    let subTitle: String
    let coursesCount: Int
    let isPremium: Bool
    let color: String
    
    //MARK: PROPERTY
    var currentCourseCount: String {
        if coursesCount > 1 {
            return String(coursesCount) + " courses"
        }
        
        return String(coursesCount) + " course"
    }
    
    
    
}
