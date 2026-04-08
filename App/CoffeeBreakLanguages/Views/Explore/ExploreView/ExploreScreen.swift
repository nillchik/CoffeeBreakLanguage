
import SwiftUI
struct ExploreScreen: View {
    @Environment(ExploreService.self) var exploreService
    @Environment(UserService.self) var userService
    @State private var viewModel = ExploreViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            switch viewModel.state {
                
            case .loading:
                JumpingSquareLoader()
                    .transition(.opacity)
                
            case .success:
                VStack(alignment: .leading, spacing: 20) {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        Header()
                        if let featured = exploreService.featuredCountry {
                            FeaturedToday(featuredCountry: featured)
                        }
                        AllLanguagesHeader()
                        AllLanguages(countries: exploreService.exploreCountries)
                        LearningPaths(paths: exploreService.learningPaths)
                        
                        
                    } .contentMargins(.top, 50, for: .scrollContent)
                        .contentMargins(.bottom, 50, for: .scrollContent)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: viewModel.state)
                }
                //MARK: DESIGN PROPERTY
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .environment(viewModel)
                .padding(.horizontal, 20)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                //MARK: NAVIGATION
                .fullScreenCover(isPresented: $viewModel.showCountryLesson) {
                    
                    if userService.isPremium {
                        
                        Text("123")
                        
                    } else {
                        
                        PremiumScreen()
                    }
                    
                    
                }
            
                .fullScreenCover(isPresented: $viewModel.showLearningPathLesson) {
                    
                    if userService.isPremium {
                        
                        Text("123")
                        
                    } else {
                        
                        PremiumScreen()
                    }
                    
                    
                }
            
                
            case .error:
                
                ContentUnavailableView {
                    Label("Connection Lost", systemImage: "wifi.exclamationmark")
                        .foregroundColor(.mainGreen)
                    
                } description: {
                    Text("Check your internet and try again.")
                        .multilineTextAlignment(.center)
                } actions: {
                    Button(action: {
                        Task {
                            await viewModel.fetchAllData(exploreService: exploreService)
                        }
                    }) {
                        
                        Text("Retry")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background {
                                
                                Capsule()
                                    .fill(.accentGreen)
                            }
                        
                        
                    }
                } .background(Color.black)
                    
                
                
                
            
            }
            
            
            
            
            
        } .animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.state)
        
        .task {
            
                await viewModel.fetchAllData(exploreService: exploreService)

            
            
        }
    }
}

#Preview {
    ExploreScreen()
        .environment(ExploreService())
        .environment(UserService())
}


private struct Header: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            HStack(spacing: 3) {
                
                Image(.sparkless)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.mainGreen)
                    .frame(maxWidth: 40, maxHeight: 40)
                Text("Discover")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
            Text("Find your next language adventure")
                .foregroundColor(.mainAsh)
                .font(.headline)
            
        } .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
        
    }
    
    
}


private struct FeaturedToday: View {
    let featuredCountry: FeaturedCountry
    @Environment(UserService.self) var userService
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            FeaturedTodayMainInformation(featuredCountry: featuredCountry)
            FeaturedTodayBottomInformation(featuredCountry: featuredCountry)
            UnlockButton()
        } .frame(maxWidth: .infinity)
            .makeExploreFeaturedCard(firstColor: Color(.green), isPremium: !userService.isPremium)
           
        
    }
    
}

private struct FeaturedTodayMainInformation: View {
    let featuredCountry: FeaturedCountry
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(featuredCountry.languageName)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(featuredCountry.subTitle)
                        .foregroundColor(.mainAsh)
                        .font(.callout)
                }
                Spacer()
                Image(featuredCountry.flagName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 90, maxHeight: 90)
            }
            
            
        } .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 40)
        
        
    }
    
}

private struct FeaturedTodayBottomInformation: View {
    let featuredCountry: FeaturedCountry
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 10) {
                InfoBadge(icon: "star.fill", title: featuredCountry.currentRating, iconForegroundStyle: .accentGreen)
                InfoBadge(icon: "person.fill", title: featuredCountry.currentNumberOfPeople, iconForegroundStyle: nil)
                InfoBadge(icon: "timer", title: featuredCountry.currentLessonCount, iconForegroundStyle: nil)
                
                
            } .foregroundColor(.mainAsh)
            
        } .frame(maxWidth: .infinity, alignment: .leading)
        
        
        
    }
    
    
}

private struct InfoBadge: View {
    let icon: String
    let title: String
    let iconForegroundStyle: Color?
    var body: some View {
        
        HStack(spacing: 3) {
            Image(systemName: icon)
                .foregroundStyle(iconForegroundStyle ?? .gray)
            Text(title)
            
            
        }
        
        
    }
    
}


private struct UnlockButton: View {
    @Environment(ExploreViewModel.self) var viewModel
    @Environment(UserService.self) var userService
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button(action: {
                
                viewModel.openCountryLessons()
                
                
            }) {
                HStack(spacing: 5) {
                    Image(systemName: !userService.isPremium ? "lock.fill" : "")
                    Text(userService.isPremium ? "Open" : "Unlock with Premium")
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        
                } .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(Color("primaryGreen"))
                
                    .cornerRadius(20)
                    .shadow(color: .primaryGreen, radius: 10)
                
            }
            
            
            
        }
        
        
        
    }
    
    
}


private struct AllLanguagesHeader: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Text("All Languages")
                .header()
                
        } .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
    }
    
    
}


private struct AllLanguages: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let countries: [ExploreCountries]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            LazyVGrid(columns: columns, alignment: .leading) {
                
                ForEach(countries, id: \.self) { country in
                    
                    LanguageButton(country: country)
                    
                    
                }
                
                
            } .frame(maxWidth: .infinity, alignment: .top)
            
            
            
        } .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
    }
    
}


private struct LanguageButton: View {
    @Environment(ExploreViewModel.self) var viewModel
    @Environment(UserService.self) var userService
    let country: ExploreCountries
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button(action: {
                
                viewModel.openCountryLessons()
                
            }) {
                
                VStack(spacing: 10) {
                    
                    Image(country.flagName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 60, maxHeight: 60)
                    Text(country.languageName)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.medium)
                    HStack(spacing: 3) {
                        Image(systemName: "person")
                            .foregroundStyle(.accentGray)
                        Text(country.currentNumberOfPeople)
                            .foregroundColor(.mainAsh)
                    }
                    if country.isPremium {
                        HStack(spacing: 3) {
                            if !userService.isPremium {
                                HStack(spacing: 10) {
                                    Image(systemName: "lock")
                                        .foregroundColor(.yellow)
                                    Text("Premium")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                        .foregroundColor(.yellow)
                                } .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                
                            }
                        }
                        .background {
                            
                            Capsule()
                                .fill(.yellow.opacity(0.3))
                                .frame(maxHeight: 20)
                                
                            
                        }
                        
                    }
                } .frame(maxWidth: .infinity)
                .makeExploreCard(color: Color(country.color).opacity(0.3), isPremium: !userService.isPremium)
                
            }
            
            
        } .frame(maxWidth: .infinity)
        
        
        
    }
    
    
}

private struct LearningPaths: View {
    let paths: [LearningPath]
    var body: some View {
        VStack(spacing: 0) {
        
            LearningPathsHeader()
            LazyVStack(spacing: 10) {
                
                ForEach(paths, id: \.self) { path in
                    
                    LearningPathButton(path: path)
                    
                    
                    
                }
                
                
                
            }
            
        } .frame(maxWidth: .infinity)
        
        
    }
    
}



private struct LearningPathsHeader: View {
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("Learning Paths")
                .header()
            
            
        } .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 20)
    
    }
    
}

private struct LearningPathButton: View {
    @Environment(ExploreViewModel.self) var viewModel
    @Environment(UserService.self) var userService
    let path: LearningPath
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                
                viewModel.openLearningPathLesson()
                
            }) {
                
                HStack(spacing: 10) {
                    
                    Image(path.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 50, maxHeight: 50)
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(path.title)
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(path.subTitle)
                            .foregroundColor(.mainAsh)
                            .fontWeight(.regular)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        Text(path.currentCourseCount)
                            .foregroundColor(.accentGray)
                        
                        
                    } .padding(.top, 5)
                    
                    Spacer()
                    VStack(spacing: 5) {
                        
                        Image(systemName: !userService.isPremium ? "lock" : "chevron.right")
                            .foregroundColor(!userService.isPremium ? .yellow : .accentGreen)
                    }
                    
                }
                
            }
            
            
            
        } .makeLearningPathCard(color: Color(path.color).opacity(0.4), isPremium: !userService.isPremium)
    }
}



