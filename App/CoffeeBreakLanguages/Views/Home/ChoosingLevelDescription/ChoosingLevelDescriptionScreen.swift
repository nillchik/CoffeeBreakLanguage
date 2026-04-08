
import SwiftUI

struct ChoosingLevelDescriptionScreen: View {
    @Environment(UserService.self) var userService
    @Environment(AudioEngine.self) var audioService
    let country: Course
    let lesson: LessonsDescription
    let course: CourseLevel
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                CoffeeImageAndCountry(country: country)
                Description(lesson: lesson, course: course)
                ProgressBar()
                ButtonPanel(lesson: lesson, country: country)
            } .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 20)
                .background(Color.black)
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        
                        BackButton()
                        
                    }
                    
                    
                    
                }
                .onDisappear {
                    
                    userService.saveProgress(lessonID: "\(lesson.id)_\(course.complexity)_\(country.countryName)", progress: audioService.progress)
                    audioService.stopPlayer()
                    
                }
               
        }
    }
}

#Preview {
    ChoosingLevelDescriptionScreen(country: Course(countryName: "Spain"), lesson: LessonsDescription(title: "GDSFGFDGF", order: 1, audioURL: ""), course: CourseLevel(complexity: .intermediate, lessons: [LessonsDescription(title: "", order: 1, audioURL: "https://anchor.fm/s/e098cffc/podcast/play/92583518/https%3A%2F%2Fd3ctxlq1ktw2nl.cloudfront.net%2Fstaging%2F2024-9-4%2F387537006-44100-2-78f034d96176e.mp3")]))
        .environment(AudioEngine())
        .environment(UserService())
}


private struct CoffeeImageAndCountry: View {
    let country: Course
    var body: some View {
        
        VStack(spacing: 0) {
            
            Image("cupOfCoffee")
            
                .resizable()
                .scaledToFit()
                .background(Color.cardColor)
                .frame(maxWidth: 300, maxHeight: 300)
            
            
        } .makeCardForCourseChooseLevelDescription(countryFlag: country)

    }
    
    
    
}

private struct Description: View {
    let lesson: LessonsDescription
    let course: CourseLevel
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Ordering Coffee")
                .header()
            Text("\(lesson.order) of \(course.lessonsCount)")
                .foregroundColor(.white)
                
            
            
        }
    }
}


private struct HelperButton: View {
    let icon: String
    let action: () -> ()
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    action()
                }
            }) {
                
                VStack(spacing: 5) {
                    
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 40)
                        .foregroundColor(.white)
                    Text("15s")
                        .foregroundColor(.mainAsh)
                    
                    
                    
                }
                
                
                
            }
        } .frame(maxWidth: .infinity)
        
        
    }
    
}

private struct PlayButton: View {
    @Environment(AudioEngine.self) var audioService
    let lesson: LessonsDescription
    let country: Course
    var body: some View {
        
        Button(action: {
            withAnimation {
                audioService.playPause(title: lesson.title, country: country.countryName, url: lesson.audioURL , lessonID: lesson.id)
            }
        }) {
            VStack(spacing: 0) {
                Image(systemName: audioService.isPlaying && lesson.id == audioService.currentLessonID ? "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background {
                        
                        Circle()
                            .fill(Color.mainGreen)
                        
                        
                    }
            } .frame(maxWidth: .infinity)
        }
        
        
    }
    
    
}

private struct ButtonPanel: View {
    @Environment(AudioEngine.self) var audioService
    let lesson: LessonsDescription
    let country: Course
    var body: some View {
        
        HStack(spacing: 0) {
            
            HelperButton(icon: "gobackward.15") {
                
                audioService.down(seconds: 15)
                
            }
            PlayButton(lesson: lesson, country: country)
            HelperButton(icon: "goforward.15") {
                
                audioService.skip(seconds: 15)
                
            }
            
            
        }
        
        
    }
    
    
}

private struct ProgressBar: View {
    @Environment(AudioEngine.self) var audioService

    var body: some View {
        
        VStack(spacing: 0) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(height: 5)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.mainGreen)
                            .frame(width: geo.size.width * CGFloat(audioService.progress), height: 5)
                }
                
                
            } .frame(height: 5)
        }
        
        
    }
    
    
}
