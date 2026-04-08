
import Foundation


protocol SettingsItem: CaseIterable, Hashable {
    var title: String { get }
    var description: String { get}
    var icon: String { get }
    var color: String { get }
    
}


enum AccountSettings: SettingsItem {
    
    case premium
    var title: String {
        switch self {
            
        case .premium:
            return "Premium Subscription"
            
        }
    }
    
    var description: String {
        switch self {
            
        case .premium:
            return "Unlock all features"
            
        }
        
    }
    
    var icon: String {
        
        switch self {
            
        case .premium:
            return "crown"
            
        }
    }
    
    var color: String {
        switch self {
        case .premium:
            return "yellow"
        }
    }
    
}


enum AppSettings: SettingsItem {
    
    case privacyPolicy
    
    
    var title: String {
        switch self {
            
        case .privacyPolicy:
            "Privacy & Security"
        }
        
    }
    
    var description: String {
        
        switch self {
            
            
        case .privacyPolicy:
            return "Manage your data"
            
        }
    }
    
    var icon: String {
        
        switch self {
            
        case .privacyPolicy:
            return "shield"
        }
        
    }
    
    var color: String {
        switch self {
        case .privacyPolicy:
            return "red"
        }
    }
    
    
}


enum SupportSettings: SettingsItem {
    
    case reportProblem
    case shareTheApp
    case rateApp
    
    var title: String {
        
        switch self {
            
            
            
        case .reportProblem:
            return "Report a Problem"
        case .shareTheApp:
            return "Share the App"
        case .rateApp:
            return "Rate our App"
        }
    }
    
    var description: String {
        
        switch self {
            
            
            
        case .reportProblem:
            return "Send us feedback"
        case .shareTheApp:
            return "Tell your friends"
        case .rateApp:
            return "Support us on App Store"
        }
        
        
    }
    
    var icon: String {
        
        switch self {
            
            
        case .reportProblem:
            return "exclamationmark.triangle"
        case .shareTheApp:
            return "shared.with.you.circle"
        case .rateApp:
            return "star"
        }
        
        
    }
    
    var color: String {
        switch self {
            
        case .reportProblem:
            return "orange"
        case .shareTheApp:
            return "blue"
        case .rateApp:
            return "yellow"
        }
    }
}
