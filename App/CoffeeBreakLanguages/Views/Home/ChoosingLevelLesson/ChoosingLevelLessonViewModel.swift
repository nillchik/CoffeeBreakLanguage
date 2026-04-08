
import Foundation


@Observable
@MainActor
class ChoosingLevelViewModel {
    
    var tappedLesson: LessonsDescription?
    var showDescriptionScreen = false
    
    func tapLesson(lesson: LessonsDescription) async {
        tappedLesson = lesson
        try? await Task.sleep(for: .seconds(0.3))
        showDescriptionScreen = true
        
        
    }
    
    
}
