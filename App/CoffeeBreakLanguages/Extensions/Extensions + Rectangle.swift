

import SwiftUI


extension View {
    
    func makeCard(isAnimating: Bool) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .fill(.card)
                .stroke(Color.accentGreen, lineWidth: isAnimating ? 1 : 0)
                .frame(maxWidth: .infinity)
                
            self
                .padding(.vertical, 20)
                
        }
        
    }
    
    
    func tabBarCurrentTab(isCurrentTab: Bool) -> some View {
            self
            .padding(5)
            .background {
                if isCurrentTab {
                    RoundedRectangle(cornerRadius: 10)
                        
                        .fill(isCurrentTab ? .accentGreen.opacity(0.4) : .clear)
                    
                }
            }
            
        
        
        
    }
    
    
    func makeCardForOrder() -> some View {
        
        self
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(.card)
                    .stroke(Color.white)
                
            }
        
        
        
    }
    
    func makeLessonCard(isAnimating: Bool) -> some View {
        self
            .padding(15)
            .frame(minHeight: 85)
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
                    .stroke(Color.accentGreen, lineWidth: isAnimating ? 1 : 0)
                    .frame(maxWidth: .infinity)
                    
                
            }
        
    }
    
    func makeCoffeCard(height: CGFloat) -> some View {
        
        self
            .padding(.horizontal, 20)
            .frame(maxHeight: height)
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
                    .shadow(color: Color.mainGreen.opacity(0.8), radius: 10, x: 1, y: 3)
                
                
            }
        
        
    }
    
    func makeCardUniversal(height: CGFloat, width: CGFloat) -> some View {
        
        self
            .frame(maxWidth: width, maxHeight: height)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
                    
                
            }
        
        
    }
    
    func makeCardForAchievement(isComplete: Bool) -> some View {
        
        self
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(alignment: .topTrailing) {
                if isComplete {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.mainGreen)
                        .padding(5)
                }
                
            }
            
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card.opacity(isComplete ? 1 : 0.3))
                    
                
            }
        
        
    }
    
    func makeLevelCard(isTapped: Bool, Color: Color) -> some View {
        
        self
            .overlay(alignment: .topTrailing) {
                
                if isTapped {
                    
                    Image(systemName: "checkmark.circle.fill")
                        
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxWidth: 60, maxHeight: 60)
                        .foregroundColor(.accentGreen)
                }
                
                
            }
            .padding(20)
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [Color, .white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .stroke(.accentGreen, lineWidth: isTapped ? 3 : 0)
                   
                
            }
        
        
    }
    
    func makeLevelIconCard(isTapped: Bool) -> some View {
        
        self
            .padding(15)
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
                    .stroke(.accentGreen, lineWidth: isTapped ? 3 : 0)
                
            }
        
        
    }
    
    func makeExploreFeaturedCard(firstColor: Color, isPremium: Bool) -> some View {
        
        self
            
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 0) {
                    if isPremium {
                        PremiumCardBadge()
                    }
                    Spacer()
                        HStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.accentGreen)
                            Text("Featured Today")
                                .foregroundColor(.primaryGreen)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                        } .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        .background {
                            Capsule()
                                .fill(.accentGreen.opacity(0.5))
                        }
                        
                            
                    
                } .padding(.bottom, 10)
            }
            .padding(20)
            .padding(.horizontal, 20)
            
        
            
        
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [firstColor.opacity(0.5), .red.opacity(0.5), .yellow.opacity(0.5), .white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                
                
            } 
        
        
    }
    
    func makeExploreCard(color: Color, isPremium: Bool) -> some View {
        
        self
            .padding(20)
            .overlay(alignment: .topTrailing) {
                if isPremium {
                    Image(systemName: "crown")
                        .foregroundColor(.black)
                        .padding(5)
                        .background {
                            Circle()
                                .fill(.yellow)
                            
                        }
                }
            } .padding(5)
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
                
                
            }
        
        
        
    }
    
    func makeLearningPathCard(color: Color, isPremium: Bool) -> some View {
        
        self
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .overlay(alignment: .topTrailing) {
                if isPremium {
                    
                    PremiumCardBadge()
                    
                }
                
                
                
            } .padding(.horizontal, 10)
            .padding(.top, 10)
            
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
                
                
            }
        
        
    }
    
    func makeSettingsImageOrder() -> some View {
        
        self
            .padding(10)
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
                    .stroke(Color.mainAsh, lineWidth: 1)
            }
        
        
        
    }
    
    func makeSettingsCard() -> some View {
        
        self
            .padding(20)
            .background {
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
            }
        
    }
    
    func makeMainCard() -> some View {
        
        self
            .padding(20)
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
                
                
            }
        
        
    }
    
    func makeCardForCourseChooseLevelDescription(countryFlag: Course) -> some View {
        
        self
            .padding(20)
            .overlay(alignment: .topTrailing) {
                
                Image(LanguageLearningCourses(from: countryFlag.countryName)?.countryFlag ?? "default_flag")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20, maxHeight: 20)
                    .padding(10)
                
                
                
            }
            .background {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.card)
                
                
            }
        
        
        
    }
    
    
    
    
    
    
    
}


