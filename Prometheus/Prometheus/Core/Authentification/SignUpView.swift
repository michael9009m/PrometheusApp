import SwiftUI
import Firebase



struct SignUpView: View {
     
    
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var showBMRView = false
    
    @State private var hasCapitalLetter = false
    @State private var hasSpecialCharacter = false
    @State private var hasMinLength = false
    
    @State private var userID: String?
    
    var body: some View {
        if userIsLoggedIn {
            if showBMRView {
                if let userID = userID {
                    BMRView(userID: userID) // Pass userID to BMRView
                } else {
                    // Optionally, you can show a loading indicator while fetching userID
                    ProgressView()
                }
            } else {
                HomeView()
            }
        } else {
            content
        }
    }
        
        
        var content: some View {
            ZStack {
                Color.black
                Color(.newbackground).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Sign up!")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -100, y: -100)
                    
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .onChange(of: password) { newValue in
                            validatePassword(password: newValue)
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: hasCapitalLetter ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(hasCapitalLetter ? .white : .beigeText)
                            Text("Capital letter")
                                .foregroundColor(.beigeText)
                        }
                        HStack {
                            Image(systemName: hasSpecialCharacter ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(hasSpecialCharacter ? .white : .beigeText)
                            Text("Special character")
                                .foregroundColor(.beigeText)
                        }
                        HStack {
                            Image(systemName: hasMinLength ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(hasMinLength ? .white : .beigeText)
                            Text("Min length (8)")
                                .foregroundColor(.beigeText)
                        }
                    }
                    
                    Button(action: register) {
                        Text("Sign up")
                            .padding()
                            .foregroundColor(.greyText)
                            .frame(maxWidth: .infinity)
                            .background(Color.beigeText)
                            .cornerRadius(5)
                            .padding(.horizontal)
                            .padding(.top, 30)
                    }
                    
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden()) {
                        Text("Already have an account? Log in")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.newbackground)
                            .border(Color.white, width: 2)
                            .cornerRadius(5)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    .offset(y: 100)
                }
                .frame(width: 350)
            }
            .ignoresSafeArea()
        }
        
        func register() {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("Error registering user: \(error.localizedDescription)")
                } else {
                    userIsLoggedIn.toggle()
                    
                    if let userID = result?.user.uid {
                        createUserDataDocument(userID: userID)
                        showBMRView = true
                        self.userID = userID // Assign userID to state
                    }
                }
            }
        }
    
   
        
        func createUserDataDocument(userID: String) {
            let db = Firestore.firestore()
            
            db.collection("Users").document(userID).setData([
                "email": email,
                "UID": userID,// Save UID field
                "date_created": Timestamp()
            ]) { error in
                if let error = error {
                    print("Error creating user data document: \(error.localizedDescription)")
                } else {
                    print("User data document created successfully")
                }
            }

        }
        
        private func validatePassword(password: String) {
            let capitalLetterRegEx = ".*[A-Z]+.*"
            let specialCharacterRegEx = ".*[^A-Za-z0-9].*"
            
            hasCapitalLetter = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegEx).evaluate(with: password)
            hasSpecialCharacter = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx).evaluate(with: password)
            hasMinLength = password.count >= 8
        }
    }


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    
    }
}



