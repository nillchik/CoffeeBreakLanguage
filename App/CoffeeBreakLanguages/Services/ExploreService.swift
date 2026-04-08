import Foundation
import Firebase
import FirebaseFirestore



@Observable
class ExploreService {
    
    private let db = Firestore.firestore()
    var exploreCountries: [ExploreCountries] = []
    var featuredCountry: FeaturedCountry?
    var learningPaths: [LearningPath] = []
    
    func fetchCountries() async {
        
        do {
            
            let snapshot = try await db.collection("exploreAllCountries").getDocuments()
            
            exploreCountries = snapshot.documents.compactMap { doc in
                
                try? doc.data(as: ExploreCountries.self)
               
                
            }
            print("Страны успешно загружены")
            
        } catch {
            
            
            print("Страны не загружены:", error.localizedDescription)
            
            
        }
        
        
        
        
    }
    
    
    func fetchFeaturedCountry() async {
        
        
        do {
            
            let snapshot = try await db.collection("featuredCountry").getDocuments()
            
            if let document = snapshot.documents.first {
                
                featuredCountry = try document.data(as: FeaturedCountry.self)
                print("Featured Country декодирована успешно")
                
            }
            
            
        } catch {
            
            print("Featured country ошибка декодирования", error.localizedDescription)
            
            
        }
        
        
        
        
    }
    
    
    func fetchLearningPath() async {
        
        do {
            
            let snapshot = try await db.collection("learningPath").order(by: "coursesCount").getDocuments()
            
            learningPaths = snapshot.documents.compactMap { doc in
                
                try? doc.data(as: LearningPath.self)
                
            }
            
            print("Learning Path успешно декодирован")
            
            
        } catch {
            
            print("Warnning: Learning Path \(error.localizedDescription)")
            
        }
        
        
        
    }
    
    
    
}
