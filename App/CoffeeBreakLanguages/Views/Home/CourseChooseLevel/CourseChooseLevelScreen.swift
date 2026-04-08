
import SwiftUI

struct CourseChooseLevelScreen: View {
    let country: Course
    
    @Environment(CourseService.self) var courseService
    @State private var viewModel = CourseChooseLevelViewModel()
    var body: some View {
       
            VStack(alignment: .leading, spacing: 10) {
                switch viewModel.state {
                case .loading:
                    
                    JumpingSquareLoader()
                    
                case .success:
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            Header(country: country)
                                .padding(.top, 10)
                            ForEach(viewModel.fetchButtons) { data in
                                
                                    LevelButton(data: data.buttonData, course: data.level)
                                    
                            }
                            
                        } .padding(.bottom, 20)
                        
                    } .contentMargins(.top, 100, for: .scrollContent)
                case .error:
                    ContentUnavailableView {
                        
                        Label("Oops...Whats Wrong", systemImage: "cloud.rain")
                    } description: {
                        Text("Please, check you internet connection and retry.")
                    } actions: {
                        Button(action: {
                            Task {
                                await viewModel.loadTask(service: courseService, country: country)
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
               
                
                   
                    
            }  .safeAreaInset(edge: .bottom) {
                
                if viewModel.tappedLevelCard != nil {
                    
                    ContinueButton()
                        .padding(.bottom, 10)
                        .transition(.move(edge: .bottom).combined(with: .slide))
                }
                
            }
            
            
            
            .toolbarBackground(.hidden, for: .navigationBar)
                .environment(viewModel)
            //MARK: DESIGN PROPERTY
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 20)
                .background(Color.black)
            //MARK: NAVIGATION PROPERTY
                .navigationBarBackButtonHidden()
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        
                        BackButton()
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                    }
                    
                    
                }
        
                //MARK: FULLSCREENCOVER
                .fullScreenCover(item: $viewModel.selectedLevelForCover) { level in
                    
                    ChoosingLevelLessonScreen(country: country, lesson: level)
                    
                }
        
        
            //MARK: TASK
                .task {
                    await viewModel.loadTask(service: courseService, country: country)
                    
                }
    }
}

#Preview {
    @Previewable var courseService = CourseService()
    let mockLevel = CourseLevel(id: "1", complexity: .beginner, lessons: [])
    let a = CourseLevel(id: "2", complexity: .intermediate, lessons: [])
    let b = CourseLevel(id: "3", complexity: .advanced, lessons: [])
        courseService.selectedCourseLevel = [mockLevel, a, b]
        
    
        
        return CourseChooseLevelScreen(country: Course(id: "test", countryName: "Spain"))
            .environment(courseService)
}


private struct Header: View {
    let country: Course
    var body: some View {
        
        HStack(spacing: 0) {
            let currentUI = LanguageLearningCourses(from: country.countryName)
            VStack(alignment: .leading, spacing: 5) {
                
                Text("Choose Your")
                    .foregroundColor(.white)
                       .font(.title)
                       .fontWeight(.bold)
                Text("Level")
                    .foregroundColor(.white)
                       .font(.title)
                       .fontWeight(.bold)
                Text("Choose your level for \(country.countryName)")
                    .foregroundColor(.mainAsh)
                
            }
                
            Spacer()
            Image(currentUI?.countryFlag ?? "default_flag")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80, maxHeight: 80)
        }
            
        
    }
    
    
}




private struct LevelButton: View {
    @Environment(CourseChooseLevelViewModel.self) var viewModel
    let data: LevelButtonData
    let course: CourseLevel
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button(action: {
                
                viewModel.levelCardTap(cardLevel: course)
                
                
            }) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Image(data.ic)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(maxWidth: 40, maxHeight: 40)
                        .makeLevelIconCard(isTapped: viewModel.tappedLevelCard?.complexity == data.complexity)
                    VStack(alignment: .center, spacing: 10) {
                        
                        Text(data.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(data.subTitle)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryGreen)
                            
                        Text(data.description)
                            .minimumScaleFactor(0.9)
                            .foregroundColor(.mainAsh)
                        HStack(spacing: 20) {
                            HStack(spacing: 3) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.mainGreen)
                                Text("\(course.lessonsCount)")
                            }
                            HStack(spacing: 5) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.blue)
                                Text(data.mounthOfEducation)
                            }
                            Spacer()
                        } .padding(.top, 20)
                            .foregroundColor(.mainAsh)
                        
                    } .frame(maxWidth: .infinity, alignment: .center)
                       
                    
                } .frame(maxWidth: .infinity, alignment: .leading)
                   
                    .makeLevelCard(isTapped: viewModel.tappedLevelCard?.complexity == data.complexity, Color: Color(data.backgroundColor))
                
            }
            
            
        }  .padding(.top, 10)
        
        
    }
}


private struct ContinueButton: View {
    @Environment(CourseChooseLevelViewModel.self) var viewModel
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button(action: {
                
                viewModel.navigateToLessons()
                
            }) {
                
                Text("Continue")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentGreen)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                
                
            }
            
            
        }
        
        
    }
    
    
}


