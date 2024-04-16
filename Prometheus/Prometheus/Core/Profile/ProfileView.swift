import SwiftUI
import Firebase

struct ProfileView: View {
    @State private var isEditing = false
    @State private var profilePicture: Image = Image(systemName: "person.circle.fill")  // Default profile picture
    @State private var bio = "Add your bio here"  // Placeholder for bio
    @State private var userName = "Jane Doe" // Default username
    @State private var gender = "Not Specified" // Default gender
    @State private var weight = 75.0 // Default weight in kg
    @State private var height = 170.0 // Default height in cm
    @State private var birthDate = Date() // Birthdate for age calculation
    @State private var fitnessGoal = "Lose weight" // Default fitness goal
    @State private var workoutFrequency = 3 // Default workout frequency per week
    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showingDetailSheet = false
    @State private var detailType: DetailType = .gender

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)  // Background color for light and dark mode
                    .edgesIgnoringSafeArea(.top)
                ScrollView {
                    VStack {
                        ProfileHeader()
                        ProfileImage(profilePicture: $profilePicture, isShowingImagePicker: $isShowingImagePicker, inputImage: $inputImage)
                        UserInfo(userName: $userName, bio: $bio, isEditing: $isEditing)
                        UserDetailsView(gender: $gender, weight: $weight, height: $height, birthDate: $birthDate, fitnessGoal: $fitnessGoal, workoutFrequency: $workoutFrequency, showingDetailSheet: $showingDetailSheet, detailType: $detailType)
                        EditProfileButton(isEditing: $isEditing)
                    }
                }
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .sheet(isPresented: $showingDetailSheet) {
                NavigationView {
                    DetailSheet(detailType: detailType, gender: $gender, weight: $weight, height: $height, birthDate: $birthDate, fitnessGoal: $fitnessGoal, workoutFrequency: $workoutFrequency)
                        .navigationBarItems(trailing: Button("Done") {
                            showingDetailSheet = false
                        })
                }
            }
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }

    func loadImage() {
        if let inputImage = self.inputImage {
            profilePicture = Image(uiImage: inputImage)
        }
    }
}

struct ProfileHeader: View {
    var body: some View {
        HStack {
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gear")
                    .imageScale(.large)
            }
            Spacer()
            Text("Profile").font(.title).fontWeight(.bold)
            Spacer()
            NavigationLink(destination: MessageView()) {
                Image(systemName: "message").imageScale(.large)
            }
        }.padding()
    }
}

struct ProfileImage: View {
    @Binding var profilePicture: Image
    @Binding var isShowingImagePicker: Bool
    @Binding var inputImage: UIImage?

    var body: some View {
        profilePicture.resizable().scaledToFill().frame(width: 120, height: 120).clipShape(Circle()).shadow(radius: 10).overlay(Circle().stroke(Color.white, lineWidth: 4)).onTapGesture {
            isShowingImagePicker = true
        }
    }
}

struct UserInfo: View {
    @Binding var userName: String
    @Binding var bio: String
    @Binding var isEditing: Bool

    var body: some View {
        VStack(alignment: .leading) {
            if isEditing {
                TextField("Username", text: $userName).font(.title)
                TextField("Bio", text: $bio).font(.body)
            } else {
                Text(userName).font(.title)
                Text(bio).font(.body)
            }
        }.padding([.horizontal, .top])
    }
}

struct UserDetailsView: View {
    @Binding var gender: String
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var birthDate: Date
    @Binding var fitnessGoal: String
    @Binding var workoutFrequency: Int
    @Binding var showingDetailSheet: Bool
    @Binding var detailType: DetailType

    var body: some View {
        Group {
            DetailButton(label: "Gender", detail: Text(gender), detailType: .gender, showingDetailSheet: $showingDetailSheet, detailTypeSelected: $detailType)
            DetailButton(label: "Weight", detail: Text("\(weight, specifier: "%.1f") kg"), detailType: .weight, showingDetailSheet: $showingDetailSheet, detailTypeSelected: $detailType)
            DetailButton(label: "Height", detail: Text("\(height, specifier: "%.1f") cm"), detailType: .height, showingDetailSheet: $showingDetailSheet, detailTypeSelected: $detailType)
            DetailButton(label: "Date of Birth", detail: Text(birthDate, style: .date), detailType: .age, showingDetailSheet: $showingDetailSheet, detailTypeSelected: $detailType)
            DetailButton(label: "Fitness Goal", detail: Text(fitnessGoal), detailType: .fitnessGoal, showingDetailSheet: $showingDetailSheet, detailTypeSelected: $detailType)
            DetailButton(label: "Workout Frequency", detail: Text("\(workoutFrequency) times/week"), detailType: .workoutFrequency, showingDetailSheet: $showingDetailSheet, detailTypeSelected: $detailType)
        }.padding(.horizontal)
    }
}

struct DetailButton<Detail>: View where Detail: View {
    var label: String
    var detail: Detail
    var detailType: DetailType
    @Binding var showingDetailSheet: Bool
    @Binding var detailTypeSelected: DetailType

    var body: some View {
        Button(action: {
            detailTypeSelected = detailType
            showingDetailSheet = true
        }) {
            HStack {
                Text(label + ":").bold()
                Spacer()
                detail
            }
        }.padding().frame(maxWidth: .infinity, alignment: .leading).background(Color(.secondarySystemBackground)).cornerRadius(10)
    }
}

struct EditProfileButton: View {
    @Binding var isEditing: Bool

    var body: some View {
        Button(action: {
            isEditing.toggle()
        }) {
            Text(isEditing ? "Save Changes" : "Edit Profile").bold().frame(maxWidth: .infinity)
        }.padding().background(Color.blue).foregroundColor(.white).cornerRadius(10).padding(.horizontal)
    }
}

struct DetailSheet: View {
    var detailType: DetailType
    @Binding var gender: String
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var birthDate: Date
    @Binding var fitnessGoal: String
    @Binding var workoutFrequency: Int

    var body: some View {
        VStack {
            switch detailType {
            case .gender:
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Non-Binary").tag("Non-Binary")
                }.pickerStyle(WheelPickerStyle())
            case .weight:
                Slider(value: $weight, in: 40...150, step: 1) {
                    Text("Weight (kg)")
                }
                Text("\(weight, specifier: "%.1f") kg").padding()
            case .height:
                Slider(value: $height, in: 140...210, step: 1) {
                    Text("Height (cm)")
                }
                Text("\(height, specifier: "%.1f") cm").padding()
            case .age:
                DatePicker("Select your birth date", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
            case .fitnessGoal:
                Picker("Fitness Goal", selection: $fitnessGoal) {
                    Text("Lose Weight").tag("Lose Weight")
                    Text("Gain Muscle").tag("Gain Muscle")
                    Text("Maintain Health").tag("Maintain Health")
                }.pickerStyle(WheelPickerStyle())
            case .workoutFrequency:
                Stepper("Workout Frequency: \(workoutFrequency) times per week", value: $workoutFrequency, in: 1...7)
            }
        }.padding()
    }
}

enum DetailType: String {
    case gender = "Gender", weight = "Weight", height = "Height", age = "Age", fitnessGoal = "Fitness Goal", workoutFrequency = "Workout Frequency"
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
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
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage  // Set the selected image
            }
            picker.dismiss(animated: true)
        }
    }
}
