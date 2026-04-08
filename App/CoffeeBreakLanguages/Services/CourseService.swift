
import Foundation
import Firebase
import FirebaseFirestore


@Observable
@MainActor
class CourseService {
    
    
    private let db = Firestore.firestore()
    var selectedCourse: Course?
    var allCourses: [Course] = []
    var selectedCourseLevel: [CourseLevel] = []
    func fetchCourse() async {
        
        do {
            
            
            let snapshot = try await db.collection("courses").getDocuments()
            
            self.allCourses = snapshot.documents.compactMap { doc in
                try? doc.data(as: Course.self)
                
            }
            print("Успешно загружено")
            
            
        } catch {
            
            print(error.localizedDescription)
            
            
        }
    
        
    }
    
    func selectCourse(country: String) {
        
        self.selectedCourse = allCourses.first(where: { $0.countryName == country})
        
    }
    
    func selectLevel(for countryID: String) async {
        self.selectedCourseLevel = []
        do {
            
            let snapshot = try await db
                .collection("courses")
                .document(countryID)
                .collection("levels")
                .getDocuments()

            self.selectedCourseLevel = snapshot.documents.compactMap { doc in
                
                try? doc.data(as: CourseLevel.self)
                
                
            }
            
            
        } catch {
            
            print("Ошибка декодирования: \(error.localizedDescription)")
            
        }
        
        
    }
    
    
}
