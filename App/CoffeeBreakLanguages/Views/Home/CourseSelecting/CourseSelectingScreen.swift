
import SwiftUI

struct CourseSelectingScreen: View {
    @Environment(CourseService.self) var courseService
    @State private var viewModel = CourseSelectingViewModel()
    @State private var ddd = ChoosingLevelDescriptionVM()
    var body: some View {
        
        NavigationStack(path: $viewModel.path) {
            VStack(alignment: .leading, spacing: 0) {
            
                ScrollView(.vertical, showsIndicators: false) {
                    Header()
                    CountriesCourses(courses: courseService.allCourses)
                }
                //MARK: CONTENT MARGINS FOR GOOD UX
                
                .contentMargins(.bottom, 100, for: .scrollContent)
                .contentMargins(.top, 50, for: .scrollContent)
            }
            
            //MARK: VSTACK DESIGN PROPERTY
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .padding(.horizontal, 20)
            .background(Color.black)
            
            //MARK: TASK
            .task {
                
                await ddd.addLevel()
                
                
            } .toolbarBackground(.hidden, for: .navigationBar)
            //MARK: ENVIRONMENT VIEWMODEL
            .environment(viewModel)
            //MARK: NAVIGATION PATH
            .navigationDestination(for: Course.self) { selectedCountry in
                
                CourseChooseLevelScreen(country: selectedCountry)
                    .environment(viewModel)
                
            }
            
        }
    }
}

#Preview {
    CourseSelectingScreen()
}


private struct Header: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 3) {
                    
                    Text("Discover")
                        .header()
                    Text("Your Course")
                        .header()
                }
                Spacer()
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    
                    .frame(maxHeight: 60)
                    .background {
                        
                        Circle()
                            .fill(.primaryGreen)
                            
                        
                    }
                
            }
               
        } .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
    }
    
    
}


private struct CountriesCourses: View {
    @Environment(CourseSelectingViewModel.self) var viewModel
    let courses: [Course]
    var body: some View {
        
        VStack(spacing: 10) {
            
            ForEach(courses) { course in
                let courseUI = LanguageLearningCourses(from: course.countryName)
                VStack(alignment: .leading, spacing: 10) {
                Image(courseUI?.countryFlag ?? "default_flag")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 80, maxHeight: 80)
                    .padding(.bottom, 10)
                Text(course.countryName)
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                Text("Complete Course")
                        .foregroundColor(.mainAsh)
                Text("From beginner to advanced")
                        .foregroundColor(.mainGray)
                        .font(.caption)
                    LearningButton(course: course)
                    
                } .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .makeCard(isAnimating: course.countryName == viewModel.selectedCountry)
                
                
            }
            
            
            
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
    }
    
}



private struct LearningButton: View {
    @Environment(CourseSelectingViewModel.self) var viewModel
    var course: Course
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation {
                    viewModel.selectedCountry(selectedCountry: course)
                }
            }) {
                
                Text("Start Learning")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(Color.primaryGreenColor)
                    .cornerRadius(20)
                    .shadow(color: .accentGreen, radius: 10)
                
            }
            
            
            
        } .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 20)
            
    }
}
