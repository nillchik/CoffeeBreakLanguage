
import Foundation
import Firebase
import FirebaseFirestore


struct FeaturedCountry: Codable {
    
    @DocumentID var id: String?
    let languageName: String
    let rating: Double
    let isPremium: Bool
    let numberOfPeople: Int
    let subTitle: String
    let flagName: String
    let lessonCount: Int
    let color: String
    
    //MARK: PROPERTY
    var currentRating: String {
        
        String(format: "%.1f", rating)
        
    }
    
    var currentNumberOfPeople: String {
        if numberOfPeople > 1000 {
            let answer = Double(numberOfPeople) / 1000.0
            return String(format: "%.1f", answer) + "k"
        } else {
            return String(numberOfPeople)
        }
    }
    
    var currentLessonCount: String {
        
        if lessonCount > 1 {
            
            String(lessonCount) + " lessons"
            
        } else {
            
            String(lessonCount) + " lesson"
        }
        
    }
    
}


struct ExploreCountries: Codable, Hashable {
    
    @DocumentID var id: String?
    let languageName: String
    let isPremium: Bool
    let numberOfPeople: Int
    let flagName: String
    let color: String
    
    //MARK: PROPERTY
    var currentNumberOfPeople: String {
        if numberOfPeople > 1000 {
            let answer = Double(numberOfPeople) / 1000.0
            return String(format: "%.1f", answer) + "k"
        } else {
            return String(numberOfPeople)
        }
    }
    
}
