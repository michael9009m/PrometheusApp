import SwiftUI

struct UserProfileSummaryView: View {
    @EnvironmentObject var viewModel: SurveyViewModel
    @State private var profileImage: Image = Image(systemName: "person.circle.fill")
    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?
    // Navigation path for iOS 16 navigation
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 20) {
                    profileImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .padding(.top, 100)
                        .onTapGesture {
                            isShowingImagePicker = true
                        }
                        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$inputImage)
                        }

                    Text("Profile Summary")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)

                    VStack(alignment: .leading, spacing: 10) {
                        DetailCardView(title: "Weight", detail: viewModel.userProfile.weight)
                        DetailCardView(title: "Height", detail: viewModel.userProfile.height)
                        DetailCardView(title: "Date of Birth", detail: formatDate(viewModel.userProfile.dob))
                        DetailCardView(title: "Fitness Goal", detail: viewModel.userProfile.fitnessGoal)
                        DetailCardView(title: "Exercise Frequency", detail: viewModel.userProfile.exerciseFrequency + " times a week")
                    }
                    .padding([.horizontal, .bottom])

                    Button("Looks Good!") {
                        // Assuming `FitnessJourneyStart` is a destination identified by an enum or similar
                        navigationPath.append(NavigationDestination.fitnessJourneyStart)
                    }
                    .buttonStyle(FilledButton())
                    .padding()
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .bottom, endPoint: .top))
            .edgesIgnoringSafeArea(.all)
        }
        // Define the destination for the navigation
        .navigationDestination(for: NavigationDestination.self) { destination in
            switch destination {
            case .fitnessJourneyStart:
                FitnessJourneyStart {
                    // Handle the action to restart the survey
                    viewModel.currentQuestionIndex = 0
                    navigationPath.removeLast()
                }
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

// Enum to identify navigation destinations
enum NavigationDestination {
    case fitnessJourneyStart
}



struct DetailCardView: View {
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(.headline)
                .foregroundColor(.gray)
            Text(detail)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 0)
        .padding(.horizontal)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }
}


