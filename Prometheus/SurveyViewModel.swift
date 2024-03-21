
// SurveyViewModel.swift

import SwiftUI

class SurveyViewModel: ObservableObject {
    @Published var userProfile = UserProfileData()
    @Published var currentQuestionIndex = 0
}

struct UserProfileData {
    var weight: String = ""
    var height: String = ""
    var age: String = ""
    var fitnessGoal: String = ""
    var exerciseFrequency: String = ""
}
