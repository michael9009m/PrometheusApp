import SwiftUI

struct QuestionHeightView: View {
    @EnvironmentObject var viewModel: SurveyViewModel

    var body: some View {
        VStack {
            ProgressBar(progress: Float(viewModel.currentQuestionIndex) / 4.0)
                .frame(height: 8)
                .padding(.horizontal)
            Spacer()
            Text("What's your height?").font(.title).foregroundColor(Color.blue)
            TextField("Height in cm", text: $viewModel.userProfile.height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            HStack {
                if viewModel.currentQuestionIndex > 0 { // Only show the Back button if not on the first question
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


