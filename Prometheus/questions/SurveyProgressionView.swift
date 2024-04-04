import SwiftUI

struct SurveyProgressionView: View {
    @EnvironmentObject var viewModel: SurveyViewModel
    @State private var showJourneyStart = false // Correctly declare this state variable

    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all) // Background color
            // Dynamically switch the question view based on currentQuestionIndex
            switch viewModel.currentQuestionIndex {
            case 0:
                QuestionWeightView().environmentObject(viewModel)
            case 1:
                QuestionHeightView().environmentObject(viewModel)
            case 2:
                QuestionDOBView().environmentObject(viewModel)
            case 3:
                QuestionFitnessGoalView(currentQuestionIndex: $viewModel.currentQuestionIndex).environmentObject(viewModel)
            case 4:
                QuestionExerciseFrequencyView(currentQuestionIndex: $viewModel.currentQuestionIndex).environmentObject(viewModel)
            default:
                if !showJourneyStart {
                    UserProfileSummaryView()
                        .environmentObject(viewModel)
                } else {
                    FitnessJourneyStart(restartSurvey: {
                        viewModel.currentQuestionIndex = 0
                        showJourneyStart = false
                    })
                }
            }
        }
        .transition(.slide) // Adds a slide transition between views
        .animation(.easeInOut, value: viewModel.currentQuestionIndex) // Animates the transition
    }
}

