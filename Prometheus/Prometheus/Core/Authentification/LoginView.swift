import SwiftUI
import Firebase

struct LoginView: View {
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
                
                Text("Already have an account?")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.top, -150)
                    .padding(.leading, -75)

                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }

                Rectangle()
                    .frame(width: 360, height: 1)
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
                    .frame(width: 360, height: 1)
                    .foregroundColor(.white)

                Button {
                    login()
                } label: {
                    Text("Login")
                        .padding()
                        .foregroundColor(.greyText)
                        .frame(maxWidth: .infinity)
                        .background(Color.beigeText)
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .padding(.top, 30)
                }
                NavigationLink(destination:ForgotView().navigationBarBackButtonHidden()) {
                    Text("Forgot Password?")
                        .foregroundColor(Color(.beigeText)) // Use asset color for text
                        .padding(.top,0.5)
                        .padding(.leading,0)
                }
            
                
                NavigationLink(destination: SignUpView().navigationBarBackButtonHidden()) {
                    Text("Already have an account? Sign up")
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

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // User successfully logged in, toggle userIsLoggedIn
                userIsLoggedIn.toggle()
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


