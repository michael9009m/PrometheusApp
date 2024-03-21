import SwiftUI

struct SurveyProgressionView: View {
    @EnvironmentObject var viewModel: SurveyViewModel

    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all) // Background color
            // Dynamically switch the question view based on currentQuestionIndex
            switch viewModel.currentQuestionIndex {
            case 0:
                QuestionWeightView()
            case 1:
                QuestionHeightView()
            case 2:
                QuestionAgeView()
            case 3:
                QuestionFitnessGoalView(currentQuestionIndex: $viewModel.currentQuestionIndex)
            case 4:
                QuestionExerciseFrequencyView(currentQuestionIndex: $viewModel.currentQuestionIndex)
            default:
                UserProfileSummaryView(userProfile: viewModel.userProfile)
            }
        }
        .transition(.slide) // Adds a slide transition between views
        .animation(.easeInOut, value: viewModel.currentQuestionIndex) // Animates the transition
    }
}
