//Task: assign a point system to workouts 

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
                            .foregroundColor(.newbackground)
                            
                            
                        // List of categories dynamically fetched from Firestore
                        VStack(spacing: 10) {
                            Button(action: { selectCategory("Arms") }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                    Text("Arms")
                                        .foregroundColor(.beigeText)
                                }
                                .frame(height: 50) // Set the height of the button
                            }
                            
                            Button(action: { selectCategory("Cardio") }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                    Text("Cardio")
                                        .foregroundColor(.beigeText)
                                }
                                .frame(height: 50)
                            }
                            
                            Button(action: { selectCategory("Core") }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                    Text("Core")
                                        .foregroundColor(.beigeText)
                                }
                                .frame(height: 50)
                            }
                            
                            Button(action: { selectCategory("Glutes") }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                    Text("Glutes")
                                        .foregroundColor(.beigeText)
                                }
                                .frame(height: 50)
                            }
                            
                            Button(action: { selectCategory("Legs") }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                    Text("Legs")
                                        .foregroundColor(.beigeText)
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
                .foregroundColor(.newbackground)
                
            
          
                
                
                
                .onAppear {
                    
                    
                    if !selectedCategories.isEmpty {
                        fetchWorkouts()
                    }
                    
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
            if completionPercentage == 100 {
                print("Gold badge!")
                // You can log the completion in Firebase or provide feedback to the user
            } else if completionPercentage >= 80 {
                print("Silver badge!")
                // Log completion in Firebase or provide feedback to the user
            } else if completionPercentage >= 50 {
                print("Bronze badge!")
                // Log completion in Firebase or provide feedback to the user
            } else {
                print("No badge earned")
            }
            // Reset for the next day
            selectedCategories = []
            workouts = []
            completionCount = 0
            totalWorkouts = 0
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
                if !isCompleted {
                    Button(action: {
                        isCompleted = true
                        onWorkoutCompleted()
                    }) {
                        Image(systemName: "checkmark.square")
                    }
                } else {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(.green)
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
