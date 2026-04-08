
import Foundation


enum MenuButtons: Int, Identifiable, CaseIterable {
    
    case home
    case explore
    case settings
    
    var id: Int { self.rawValue }
    
    //MARK: MENU BUTTONS TITLE
    var title: String {
        
        
        switch self {
        case .home:
            return "Home"
        case .explore:
            return "Explore"
        case .settings:
            return "Settings"
        }
        
    }
    
    //MARK: MENU BUTTONS ICON
    
    var icon: String {
        
        switch self {
            
        case .home:
            return "house"
        case .explore:
            return "safari"
        case .settings:
            return "gearshape"
        }
        
    }
    
    
}
