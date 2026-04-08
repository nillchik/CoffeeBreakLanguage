

import Foundation

//MARK: STRUCT OF LEVEL BUTTONS
struct LevelButtonData: Hashable {
    
    let title: String
    let backgroundColor: String
    let ic: String
    let subTitle: String
    let description: String
    let mounthOfEducation: String
    let complexity: LessonsComplexity
    
}

//MARK: ARRAY OF LESSON BUTTONS
let levelButtons: [LevelButtonData] = [LevelButtonData(title: "Beginner", backgroundColor: "emeraldColor", ic: "sparkless", subTitle: "Start your journey", description: "Perfect for those just starting out. Learn basic vocabulary, grammar, and essential phrases.", mounthOfEducation: "3-4 months", complexity: .beginner),
                                       LevelButtonData(title: "Intermediate", backgroundColor: "lazuritColor", ic: "mortarboard", subTitle: "Build your confidence", description: "Expand your vocabulary and improve conversational skills. Great for everyday communication", mounthOfEducation: "4-5 months", complexity: .intermediate),
                                       
                                       LevelButtonData(title: "Advanced", backgroundColor: "amaranthineColor", ic: "cup", subTitle: "Master the language", description: "Perfect your accent, learn complex idioms, and engage in professional-level discussions", mounthOfEducation: "5-6 months", complexity: .advanced)
                                       


]


struct ButtonsOfFirebase: Identifiable {
    var id = UUID()
    let buttonData: LevelButtonData
    let level: CourseLevel
    
    
}
