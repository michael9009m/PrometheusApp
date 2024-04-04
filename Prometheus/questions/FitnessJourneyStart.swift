import SwiftUI

struct FitnessJourneyStart: View {
    var restartSurvey: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("Let's Start Your Fitness Journey")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Button("Let me change something") {
                // Call the closure to reset survey
                restartSurvey()
            }
            .buttonStyle(FilledButton())
            .padding()
        }
    }
}
