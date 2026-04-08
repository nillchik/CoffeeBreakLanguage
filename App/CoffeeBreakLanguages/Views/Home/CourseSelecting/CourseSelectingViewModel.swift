
    import Foundation

    @Observable
    class CourseSelectingViewModel {
        
        var selectedCountry: String?
        var path: [Course] = []
        
        func selectedCountry(selectedCountry: Course) {
            Task {
                self.selectedCountry = selectedCountry.countryName
                try await Task.sleep(nanoseconds: 400000000)
                path.append(selectedCountry)
                self.selectedCountry = nil
                
            }
            
        }
        
        
    }
