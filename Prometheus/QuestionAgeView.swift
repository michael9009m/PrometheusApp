import SwiftUI

struct QuestionAgeView: View {
    @EnvironmentObject var viewModel: SurveyViewModel

    var body: some View {
        VStack(spacing: 20) {
            ProgressBar(progress: Float(viewModel.currentQuestionIndex) / 4.0)
                .frame(height: 8)
                .padding(.horizontal)

            Spacer(minLength: 20)
            
            Text("Slide to select your age")
                .font(.title)
                .foregroundColor(Color.blue)
                .padding(.bottom, 20)
            
            Text(viewModel.userProfile.age.isEmpty ? "25" : viewModel.userProfile.age)
                .font(.system(size: 36))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
                .background(Circle()
                                .fill(Color.blue)
                                .frame(width: 100, height: 100))
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
            
            Slider(value: Binding(get: {
                Double(viewModel.userProfile.age) ?? 25
            }, set: {
                viewModel.userProfile.age = String(format: "%.0f", $0)
            }), in: 18...80)
                .accentColor(Color.blue)
                .padding(.horizontal)

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


