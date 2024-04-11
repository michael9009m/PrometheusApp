import SwiftUI

struct SurveyProgressionView: View {
    @EnvironmentObject var viewModel: SurveyViewModel

    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)
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
                UserProfileSummaryView()
                    .environmentObject(viewModel)
            }
        }
        .transition(.slide)
        .animation(.easeInOut, value: viewModel.currentQuestionIndex)
    }
}

