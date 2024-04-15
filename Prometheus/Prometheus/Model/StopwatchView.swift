import SwiftUI

struct StopwatchView: View {
    let workout: Workout
    @Binding var onWorkoutDone: (TimeInterval) -> Void // Callback function to log duration
    @State private var isRunning: Bool = false
    @State private var startTime: Date?
    @State private var duration: TimeInterval = 0

    var body: some View {
        VStack {
            Text(workout.name)
                .font(.title)
                .padding()

            // Display the elapsed time
            Text("Time: \(duration / 60, specifier: "%.2f") min")
                .font(.headline)
                .padding()
            
            // Start/Stop button
            Button(action: {
                if isRunning {
                    stopTimer()
                } else {
                    startTimer()
                }
            }) {
                Text(isRunning ? "Stop" : "Start")
                    .padding()
                    .background(isRunning ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // Done button (only visible if the timer is running)
            if isRunning {
                Button(action: doneWorkout) {
                    Text("Done")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
        }
        .padding()
    }

    // Function to start the timer
    func startTimer() {
        isRunning = true
        startTime = Date()
    }

    // Function to stop the timer
    func stopTimer() {
        guard let startTime = startTime else { return }
        isRunning = false
        let endTime = Date()
        duration += endTime.timeIntervalSince(startTime)
    }

    // Function to complete the workout and log the duration
    func doneWorkout() {
        stopTimer()
        onWorkoutDone(duration)
        // Dismiss the view or navigate back as appropriate
    }
}

