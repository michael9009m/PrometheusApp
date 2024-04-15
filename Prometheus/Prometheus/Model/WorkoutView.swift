import SwiftUI
import Firebase

struct WorkoutView: View {
    
    @State private var selectedCategories: [String] = []
    @State private var workouts: [Workout] = []
    @State private var completionCount: Int = 0
    @State private var totalWorkouts: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedCategories.isEmpty {
                    Text("What do you want to hit today?")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    // List of categories dynamically fetched from Firestore
                    VStack(spacing: 10) {
                        Button(action: { selectCategory("Arms") }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                Text("Arms")
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50) // Set the height of the button
                            
                        }
                        
                        Button(action: { selectCategory("Cardio") }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                Text("Cardio")
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                        }
                        
                        Button(action: { selectCategory("Core") }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                Text("Core")
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                        }
                        
                        Button(action: { selectCategory("Glutes") }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                Text("Glutes")
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                        }
                        
                        Button(action: { selectCategory("Legs") }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                Text("Legs")
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                        }
                    }
                    .padding()
                } else {
                    List(workouts) { workout in
                        WorkoutRow(workout: workout, onWorkoutCompleted: {
                            completionCount += 1
                        })
                    }
                    Button(action: {
                        completeWorkoutSession()
                    }) {
                        Text("Done")
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Daily Workout Plan")
        }
        .foregroundColor(.primary)
        .onAppear {
            if !selectedCategories.isEmpty {
                fetchWorkouts()
            }
        }
    }
    
    func selectCategory(_ category: String) {
        selectedCategories.append(category)
        fetchWorkouts()
    }
    
    func fetchWorkouts() {
        let db = Firestore.firestore()
        let documentReference = db.collection("Workouts").document("YFhOIxSsBN75Eq9h4Vdy") // Adjust document ID if necessary
        documentReference.getDocument { document, error in
            if let error = error {
                // Handle error (e.g., log it)
                print("Error fetching document: \(error.localizedDescription)")
            } else if let document = document, document.exists {
                // Extract data from the document
                if let data = document.data() {
                    var fetchedWorkouts: [Workout] = []
                    // Iterate through selected categories
                    for category in selectedCategories {
                        if let categoryData = data[category] as? [String: String] {
                            // Create a list of workouts for the selected category
                            var categoryWorkouts: [Workout] = []
                            for (key, workoutName) in categoryData {
                                let workout = Workout(id: "\(category)-\(key)", name: workoutName)
                                categoryWorkouts.append(workout)
                            }
                            // Shuffle and select up to 5 workouts
                            categoryWorkouts.shuffle()
                            fetchedWorkouts.append(contentsOf: Array(categoryWorkouts.prefix(5)))
                        }
                    }
                    // Combine and shuffle the results from all selected categories
                    fetchedWorkouts.shuffle()
                    // Keep only up to 10 workouts (or fewer if not enough are available)
                    workouts = Array(fetchedWorkouts.prefix(10))
                    totalWorkouts = workouts.count
                }
            }
        }
    }
    
    func completeWorkoutSession() {
        let completionPercentage = Double(completionCount) / Double(totalWorkouts) * 100
        
        var badge = ""
        if completionPercentage == 100 {
            badge = "Gold"
        } else if completionPercentage >= 80 {
            badge = "Silver"
        } else if completionPercentage >= 50 {
            badge = "Bronze"
        } else {
            badge = "None"
        }
        
        // Log the badge and completion details into the database
        logCompletion(badge: badge, percentage: completionPercentage)
        
        // Reset for the next day
        selectedCategories = []
        workouts = []
        completionCount = 0
        totalWorkouts = 0
    }
    
    func logCompletion(badge: String, percentage: Double) {
        // Here you can log the badge and completion percentage to the database
        let db = Firestore.firestore()
        let completionData: [String: Any] = [
            "badge": badge,
            "percentage": percentage
        ]
        db.collection("Workout Histories").document("dummy history").setData(completionData) { error in
            if let error = error {
                print("Error logging completion: \(error.localizedDescription)")
            } else {
                print("Completion logged successfully.")
            }
        }
    }
}

struct WorkoutRow: View {
    let workout: Workout
    var onWorkoutCompleted: () -> Void
    @State private var isCompleted: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.name)
                    .font(.headline)
            }
            Spacer()
            Button(action: {
                isCompleted.toggle()
                if isCompleted {
                    onWorkoutCompleted()
                }
            }) {
                Image(systemName: isCompleted ? "checkmark.square.fill" : "checkmark.square")
                    .foregroundColor(isCompleted ? .green : .primary)
            }
        }
    }
}

struct Workout: Identifiable {
    let id: String
    let name: String
    // Add more workout attributes as needed
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
