

import SwiftUI


extension Color {
    
    static let mainGreen = Color("accentGreen")
    static let mainGray = Color("accentGray")
    static let mainAsh = Color("accentAsh")
    static let cardColor = Color("cardColor")
    static let primaryGreenColor = Color("primaryGreen")
    static let wineRedColor = Color("wineColor")
    static let brightRedColor = Color("brightRedColor")
    static let gold = Color("premiumGold")
}


extension Color {
    
    init(from: String) {
        
        switch from {
        case "yellow": self = .yellow
        case "red": self = .red
        case "blue": self = .blue
        case "orange": self = .orange
        default: self = .gray
            
            
            
        }
        
        
    }
    
    
    
    
}
