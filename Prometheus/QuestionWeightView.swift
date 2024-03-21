import SwiftUI

struct QuestionWeightView: View {
    @EnvironmentObject var viewModel: SurveyViewModel

    var body: some View {
        VStack {
            ProgressBar(progress: Float(viewModel.currentQuestionIndex) / 4.0)
                .frame(height: 8)
                .padding(.horizontal)
            Spacer()
            Text("What's your weight?").font(.title).foregroundColor(Color.blue)
            TextField("Weight in kg", text: $viewModel.userProfile.weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.decimalPad)
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

struct FilledButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
