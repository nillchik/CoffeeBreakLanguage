
import SwiftUI

struct ChoosingLevelLessonScreen: View {
    let country: Course
    let lesson: CourseLevel
    
    @State private var viewModel = ChoosingLevelViewModel()
    @Environment(AudioEngine.self) var player
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(lesson.lessons, id: \.order) { item in
                        
                        LessonRow(item: item, country: country, lesson: lesson)
                        
                    }
                }
            } .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .background(Color.black)

                .toolbarBackground(.black, for: .navigationBar)
                .environment(viewModel)
        
                .fullScreenCover(item: $viewModel.tappedLesson) { tappedLesson in
                    
                    ChoosingLevelDescriptionScreen(country: country, lesson: tappedLesson, course: lesson)
                       
                    
                    
                }
                
            
            //MARK: TOOLBAR
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    BackButton()
                        .padding(.top, 10)
                    
                }
                
                ToolbarItem(placement: .principal) {
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(country.countryName)
                            .font(.headline)
                            .foregroundColor(.white)
                    
                        Text("\(lesson.complexity)".capitalized)
                            .foregroundColor(.mainAsh)
                            .font(.caption)
                           
                        
                    }
                    
                }
                
                
            }
        }
    }
}

#Preview {
    ChoosingLevelLessonScreen(country: Course(countryName: "Spain"), lesson: CourseLevel(complexity: .beginner, lessons: [LessonsDescription(title: "Grettings & Introduction", order: 1, audioURL: "")]))
        .environment(AudioEngine())
        .environment(UserService())
}


private struct PlayButton: View {
    @Environment(AudioEngine.self) var player
    let item: LessonsDescription
    let country: Course
    var body: some View {
        
        Button(action: {
            withAnimation {
                player.playPause(title: item.title, country: country.countryName, url: item.audioURL, lessonID: item.id)
                Task {
                    await player.updateMetadataAsync(title: item.title, country: country.countryName)
                }
            }
        }) {
            
            Image(systemName: player.isPlaying && player.currentLessonID == item.id ? "pause.fill" : "play.fill")
                .padding()
                .foregroundColor(.black)
                .background {
                    
                    Circle()
                        .fill(.accentGreen)
                    
                    
                }
            
            
            
        }
        
        
        
    }
    
}

private struct DownloadButton: View {
    
    var body: some View {
        Button(action: {
            
            
        }) {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .scaledToFit()
                .foregroundColor(.mainAsh)
                .frame(maxHeight: 20)
            
        }
    }
    
}


private struct MainButtons: View {
    let item: LessonsDescription
    let country: Course
    var body: some View {
        
        HStack(spacing: 20) {
            DownloadButton()
            PlayButton(item: item, country: country)
        }
        
    }
    
}

private struct LessonRow: View {
    let item: LessonsDescription
    let country: Course
    let lesson: CourseLevel
    @Environment(ChoosingLevelViewModel.self) var viewModel
    @Environment(AudioEngine.self) var player
    @Environment(UserService.self) var userService
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button(action: {
                Task {
                    await viewModel.tapLesson(lesson: item)
                    
                }
            }) {
                
                HStack(spacing: 15) {
                    Text("\(item.order)")
                        .foregroundColor(.white)
                        
                        .font(.headline)
                        .makeCardForOrder()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.title)
                            .foregroundColor(.white)
                            
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.9)
                            .tracking(-0.2)
                            .font(Font.system(size: 15))
                            .allowsTightening(true)
                        HStack(spacing: 5) {
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.mainAsh)
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.mainGreen)
                                        .frame(width: geo.size.width * CGFloat(userService.getProgress(lessonID: "\(item.id)_\(lesson.complexity)_\(country.countryName)")))
                                    
                                }
                                
                                
                            } .frame(height: 5)
                            Text("\(Int(userService.getProgress(lessonID: "\(item.id)_\(lesson.complexity)_\(country.countryName)") * 100))%")
                                .foregroundColor(.mainAsh)
                                .font(.footnote)
                        }
                    }
                    
                   Spacer()
                    
                    MainButtons(item: item, country: country)
                } .makeLessonCard(isAnimating: viewModel.tappedLesson == item || item.audioURL == player.currentURL)
                
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
}


