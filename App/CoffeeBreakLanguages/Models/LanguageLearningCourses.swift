
import Foundation

//MARK: COURSES CARD IN HOME
enum LanguageLearningCourses: Int, Identifiable, CaseIterable, Hashable {
    
    case spain
    case french
    case german
    
    
    var id: Int { rawValue.self }
    
    var countryFlag: String {
        
        switch self {
            
        case .spain:
            return "spain_ic"
        case .french:
            return "france_ic"
        case .german:
            return "germany_ic"
        }
    }
    
    var countryName: String {
        
        switch self {
            
        case .spain:
            return "Spain"
        case .french:
            return "French"
        case .german:
            return "Germany"
        }
        
        
    }
    
    
}

extension LanguageLearningCourses {
    
    init?(from countryName: String) {
        
        self = LanguageLearningCourses.allCases.first { countryName == $0.countryName} ?? .spain
        
    }
    
    
}
