import Foundation

enum CourseScreenState {
    
    case loading
    case success
    case error
    
    
}


@Observable
class CourseChooseLevelViewModel {
    
    var tappedLevelCard: CourseLevel?
    var selectedLevelForCover: CourseLevel?
    var fetchButtons: [ButtonsOfFirebase] = []
    var readyToShow: Bool = false
    var visibleCards: Set<UUID> = []
    var state: CourseScreenState = .loading
    
    func levelCardTap(cardLevel: CourseLevel) {
        
        tappedLevelCard = cardLevel
        
        
    }
    
    func navigateToLessons() {
        selectedLevelForCover = tappedLevelCard
    }
    
    func getButtons(courseLevels: [CourseLevel]) -> [ButtonsOfFirebase] {
        
        let result = levelButtons.compactMap { level -> ButtonsOfFirebase? in
            guard let foundLevel = courseLevels.first(where: { $0.complexity == level.complexity }) else { return nil }
                return ButtonsOfFirebase(buttonData: level, level: foundLevel)
            
            
        }
        return result

    }
    
    
    func loadTask(service: CourseService, country: Course) async {
        state = .loading
        do {
            
            guard let id = country.id else { return }
            
            await service.selectLevel(for: id)
            
            let buttons = await getButtons(courseLevels: service.selectedCourseLevel)
            
            if buttons.isEmpty {
                
                state = .error
            } else {
                
                self.fetchButtons = buttons
                
            }
            
            state = .success
            
            
            
        } 
        
        
        
    }
    
    
}
