import SwiftUI

struct QuestionDOBView: View {
    @EnvironmentObject var viewModel: SurveyViewModel

    var body: some View {
        VStack {
            ProgressBar(progress: Float(viewModel.currentQuestionIndex) / 4.0)
                .frame(height: 8)
                .padding(.horizontal)

            Spacer()
            
            Text("What's your date of birth?")
                .font(.title)
                .foregroundColor(Color.blue)
                .padding(.bottom, 20)
            
            DatePicker(
                "Select your date of birth",
                selection: $viewModel.userProfile.dob,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()

            HStack {
                if viewModel.currentQuestionIndex > 0 {
                    Button("Back") {
                        withAnimation {
                            viewModel.currentQuestionIndex -= 1
                        }
                    }
                    .buttonStyle(FilledButton())
                }
                
                Spacer()
                
                Button("Next") {
                    withAnimation {
                        viewModel.currentQuestionIndex += 1
                    }
                }
                .buttonStyle(FilledButton())
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}
