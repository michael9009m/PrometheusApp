import SwiftUI

class SurveyViewModel: ObservableObject {
    @Published var userProfile = UserProfileData()
    @Published var currentQuestionIndex = 0
}

struct UserProfileData {
    var weight: String = ""
    var height: String = ""
    var dob: Date = Date()
    var fitnessGoal: String = ""
    var exerciseFrequency: String = ""
}
