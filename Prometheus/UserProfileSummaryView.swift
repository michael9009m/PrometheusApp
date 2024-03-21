import SwiftUI

struct UserProfileSummaryView: View {
    @State private var profileImage: Image = Image(systemName: "person.circle.fill") // Default placeholder image
    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?

    var userProfile: UserProfileData

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Image
                profileImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .padding(.top, 100)
                    .onTapGesture {
                        self.isShowingImagePicker = true
                    }
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                
                Text("Profile Summary").font(.title).foregroundColor(Color.white)
                // Survey Answers
                VStack(alignment: .leading, spacing: 10) {
                    // Weight Card
                    DetailCardView(title: "Weight", detail: userProfile.weight + " kg")

                    // Height Card
                    DetailCardView(title: "Height", detail: userProfile.height + " cm")

                    // Age Card
                    DetailCardView(title: "Age", detail: userProfile.age)

                    // Fitness Goal Card
                    DetailCardView(title: "Fitness Goal", detail: userProfile.fitnessGoal)

                    // Exercise Frequency Card
                    DetailCardView(title: "Exercise Frequency", detail: userProfile.exerciseFrequency)
                }
                .padding([.horizontal, .bottom])
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .bottom, endPoint: .center))
        .edgesIgnoringSafeArea(.top)
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
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

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }
}


