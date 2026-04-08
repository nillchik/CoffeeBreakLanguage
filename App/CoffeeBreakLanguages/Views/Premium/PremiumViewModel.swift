

import Foundation


@Observable
class PremiumScreenViewModel {
    var rectangle: SubscriptionPlan = .yearly
    
    func rectangleTap(onRectangle: SubscriptionPlan) {
        
        rectangle = onRectangle
        
    }
    
    
    
}
