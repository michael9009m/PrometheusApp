import SwiftUI

struct QuestionFitnessGoalView: View {
    @Binding var currentQuestionIndex: Int
    @State private var selectedFitnessGoal: String = ""
    
    // Define your fitness goals here
    let fitnessGoals = ["Lose Weight", "Gain Muscle", "Improve Stamina", "Increase Flexibility", "General Health"]

    var body: some View {
        VStack {
            // ProgressBar integration
                        ProgressBar(progress: Float(currentQuestionIndex) / 4.0) // Since there are 5 questions, dividing by 4 (0-indexed)
                            .frame(height: 8)
                            .padding(.horizontal)
            Spacer()
            Text("What's your fitness goal?").font(.title).foregroundColor(Color.blue)
            
            Picker("Select your goal", selection: $selectedFitnessGoal) {
                ForEach(fitnessGoals, id: \.self) { goal in
                    Text(goal).tag(goal)
                }
            }
            .pickerStyle(WheelPickerStyle()) // You can change this to .segmentedPickerStyle() or others as per your UI requirement
            .background(Color.blue.opacity(0.1)) // Optional: Adds a light blue background to the picker
            .cornerRadius(10) // Optional: Rounds the corners of the picker background
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
                
                // Next button
                Button("Next") {
                    withAnimation {
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


