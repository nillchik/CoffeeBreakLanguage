
import Foundation

let premiumFeatures: [String] = ["Unlimited access to all courses", "Download lessons for offline listening", "Ad-free learning experience",
"Priority customer support", "Exclusive premium content", "Progress sync across devices", "Advanced learning analytics", "Early access to new courses"
]



enum SubscriptionPlan: String, Identifiable, CaseIterable, Hashable {
    
    case monthly = "Monthly plan"
    case yearly = "Annual Plan"
    
    var id: String { rawValue }
    
    var price: String {
        
        switch self {
            
        case .monthly:
            return "$9.99"
        case .yearly:
            return "$59.99"
            
        }
        
    }
    
    var period: String {
        
        
        switch self {
            
            
        case .monthly:
            "per month"
        case .yearly:
            "per year"
        }
        
        
    }
    
    var convenience: String? {
        
        switch self {
            
            
            
        case .monthly:
            nil
        case .yearly:
            "Save 50%"
            
        }
        
        
        
    }
    
    
    
}

enum LegalDocument: String, Identifiable, CaseIterable {
    
    case termOfUs = "Term of Use"
    case privacyPolicy = "Privacy Policy"
    case restorePurchase = "Restore Purschase"
    
    var id: String { rawValue }
    
    var title: String {
        
        switch self {
            
        case .termOfUs:
            "Term of Us"
        case .privacyPolicy:
            "Privacy Policy"
        case .restorePurchase:
            "Restore Purchase"
        }
        
        
    }
    
    
}
