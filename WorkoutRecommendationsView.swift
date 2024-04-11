import SwiftUI
import AVKit // Necessary if you plan to embed videos in the future

// Enum defining the different sections of the workout
enum WorkoutSection: String, CaseIterable, Identifiable {
    case warmup = "Warmup"
    case activation = "Activation (Core & Balance)"
    case skillDevelopment = "Skill Development (Plyometric & SAQ)"
    case resistanceTraining = "Resistance Training"
    case coolDown = "Cool-Down"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        return self.rawValue
    }
}

// Struct representing each exercise
struct Exercise {
    let name: String
    let description: String
    let videoID: String // YouTube video ID for embedding
}

struct WorkoutRecommendationsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Personalized Workout Routines")
                    .font(.title)
                    .fontWeight(.bold)

                ForEach(WorkoutSection.allCases) { section in
                    SectionView(section: section, exercises: exercises(for: section))
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Workout Recommendations")
    }

    // Function to return exercises based on the workout section
    private func exercises(for section: WorkoutSection) -> [Exercise] {
        switch section {
        case .warmup:
            return [
                Exercise(name: "Jumping Jacks", description: "A full body exercise that increases aerobic fitness, strengthens the body", videoID: "nGaXj3kkmrU"),
                Exercise(name: "Dynamic Stretching", description: "Prepares your muscles for a workout by stretching them in motion", videoID: "VW42KKmjEZY"),
                Exercise(name: "Arm Circles", description: "Warms up the shoulders and improves range of motion", videoID: "bP52FXTlzjA")
            ]
        case .activation:
            return [
                Exercise(name: "Plank", description: "Activates core muscles and improves balance", videoID: "pSHjTRCQxIw"),
                Exercise(name: "Glute Bridge", description: "Activates glutes and core for balance and stability", videoID: "8bbE64NuDTU")
            ]
        case .skillDevelopment:
            return [
                Exercise(name: "Box Jumps", description: "Improves explosive power, coordination, and speed", videoID: "MkGRfVGyIMA")
            ]
        case .resistanceTraining:
            return [
                Exercise(name: "Squats", description: "Targets lower body and core for strength", videoID: "U3HlEF_E9fo"),
                Exercise(name: "Push-Ups", description: "Works the upper body and core for balanced strength", videoID: "IODxDxX7oi4"),
                Exercise(name: "Pull-Ups", description: "Strengthens the back, shoulders, and arms", videoID: "eGo4IYlbE5g"),
                Exercise(name: "Lunges", description: "Targets the thighs, hips, and buttocks", videoID: "QOVaHwm-Q6U"),
                Exercise(name: "Deadlifts", description: "Engages the entire posterior chain for overall strength", videoID: "ytGaGIn3SjE")
            ]
        case .coolDown:
            return [
                Exercise(name: "Stretching", description: "Lowers body temperature and improves flexibility", videoID: "g_tea8ZNk5A"),
                Exercise(name: "Foam Rolling", description: "Reduces muscle tightness and improves blood flow", videoID: "9fvaZ_U6o3Y"),
                Exercise(name: "Deep Breathing", description: "Helps in recovery and relaxation", videoID: "vghmIqMYBcc")
            ]
        }
    }
}

struct SectionView: View {
    let section: WorkoutSection
    let exercises: [Exercise]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(section.displayName)
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(exercises, id: \.name) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name).fontWeight(.bold)
                    Text(exercise.description).padding(.bottom, 2)
                    WebView(urlString: "https://www.youtube.com/embed/\(exercise.videoID)")
                        .frame(height: 200)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.secondary.opacity(0.5), lineWidth: 0.5)
                        )
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

