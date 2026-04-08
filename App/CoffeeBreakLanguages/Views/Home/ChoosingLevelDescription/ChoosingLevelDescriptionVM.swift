
import Foundation
import Firebase
import FirebaseFirestore

@Observable
class ChoosingLevelDescriptionVM {
    
    private let db = Firestore.firestore()
    
    func addLevel() async {
        
        let levelRef = db.collection("courses").document("vnbaEqhJjuHaoYYiT0aD").collection("levels").document("5A8fdgrZElPedsEpJQ72")
        let levelRef2 = db.collection("courses").document("vnbaEqhJjuHaoYYiT0aD").collection("levels").document("HWKIAlwH6bqpu7tXJfUF")
        let levelRef3 = db.collection("courses").document("vnbaEqhJjuHaoYYiT0aD").collection("levels").document("hYk9g68uiDpgwusB6KE9")
        do {
            
            let newLesson: [[String: Any]] = [
                [
                "order": 1,
                
                "title": "Greetings&Introduction",
                
                "audioURL": ""
                
                
            ],
            
            [
                
                "order": 2,
                "title": "Count like a local: Numbers 1-100",
                "audioURL": ""
                
                
            ],
            [
                "order": 3,
                "title": "Calendars Talk: Days & Months",
                "audioURL": ""
            ],
                [
                    "order": 4,
                    "title": "Lost in the City? Ask for Directions",
                    "audioURL": ""
                ],
                
                [
                    "order": 5,
                    "title": "Coffee Culture: Ordering Drinks",
                    "audioURL": ""
                ],
                
                [
                    "order": 6,
                    "title": "Dining Out: Restaraunt Essentials",
                    "audioURL": ""
                ],
                
                [
                    "order": 7,
                    "title": "Market Barganing & Shopping",
                    "audioURL": ""
                ],
                
                [
                    "order": 8,
                    "title": "Small Talk: Weather&Climate",
                    "audioURL": ""
                ],
                
                
                [
                    "order": 9,
                    "title": "Airport & Hotel Survival Phrases",
                    "audioURL": ""
                ],
                
                [
                    "order": 10,
                    "title": "Breaking the Ice: Making Friends",
                    "audioURL": ""
                ],
                [
                    "order": 11,
                    "title": "Mi Familia: Family & Loved Ones",
                    "audioURL": ""
                ], [
                    "order": 12,
                    "title": "Passion Project: Hobbies&Free Time",
                    "audioURL": ""
                ]
            
            
            ]
            
            try await levelRef.setData(["lessons" : newLesson], merge: true)
            try await levelRef2.setData(["lessons" : newLesson], merge: true)
            try await levelRef3.setData(["lessons" : newLesson], merge: true)
            
        } catch {
            print("Ошибка заполнения данных:")
            print(error.localizedDescription)
            
            
        }
        
        
        
    }
    
    
    
    
}

