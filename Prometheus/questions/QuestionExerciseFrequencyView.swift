import SwiftUI

struct QuestionExerciseFrequencyView: View {
    @Binding var currentQuestionIndex: Int
        @EnvironmentObject var viewModel: SurveyViewModel
        @State private var exerciseFrequency: Double = 3 // Starting Value, adjust as needed

    var body: some View {
        VStack {

            ProgressBar(progress: Float(currentQuestionIndex) / 4.0) // Since there are 5 questions, dividing by 4 (0-indexed)
                .frame(height: 8)
                .padding(.horizontal)
            Spacer()
            Text("How often do you exercise per week?").font(.title).foregroundColor(Color.blue)
            Text("\(Int(exerciseFrequency)) times")
                .font(.headline)
                .foregroundColor(Color.blue.opacity(0.8))
                .padding()

            Slider(value: $exerciseFrequency, in: 0...7, step: 1)
                .accentColor(Color.blue)
                .padding()

            HStack {
                // Back button
                if currentQuestionIndex > 0 { // Only show the Back button if not on the first question
                    Button("Back") {
                        withAnimation {
                            currentQuestionIndex -= 1
                        }
                    }
                    .buttonStyle(FilledButton())
                }
                
                Spacer()
                
                Button("Next") {
                    withAnimation {
                        let newFrequency = String(format: "%.0f", exerciseFrequency)
                        viewModel.userProfile.exerciseFrequency = newFrequency
                        currentQuestionIndex += 1
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
