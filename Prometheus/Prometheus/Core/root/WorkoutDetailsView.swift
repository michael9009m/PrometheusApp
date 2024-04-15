import SwiftUI

struct WorkoutDetailsView: View {
    let workoutName: String
    @Binding var isPresented: Bool // Binding to control sheet dismissal
    
    var body: some View {
        VStack {
            Text("Workout: \(workoutName)")
                .font(.title)
            Text("Stopwatch") // Placeholder for stopwatch
            Button(action: {
                // Dismiss the sheet
                isPresented = false
            }) {
                Text("Close")
                    .foregroundColor(.blue)
            }
            .padding()
        }
    }
}

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailsView(workoutName: "Sample Workout", isPresented: .constant(false))
    }
}
