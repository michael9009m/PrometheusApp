import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
            
            HomeView()
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
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    
                    register()
                } label: {
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
                    print(error.localizedDescription)
                } else {
                    // User successfully registered, toggle userIsLoggedIn
                    userIsLoggedIn.toggle()
                }
            }
        }
    }
    
    struct Welcome_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
