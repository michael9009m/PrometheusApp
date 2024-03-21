// created by Abigail Abeyta
//

import SwiftUI
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(.newbackground).edgesIgnoringSafeArea(.all) // Set dark grey background color
                VStack {
                    Text("Already have an\naccount?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.beigeText)
                    
                        .padding(.top, 30)
                        .padding(.leading, -75)
                    
                    // Add your login form components here
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.secondary.opacity(0.4)) // Set the background color to gray
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .foregroundColor(.white) // Set the text color to black for better contrast
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.secondary.opacity(0.4)) // Set the background color to gray
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .foregroundColor(.white) // Set the text color to black for better contrast
                    
                    NavigationLink(destination:ForgotView()) {
                        Text("Forgot Password?")
                            .foregroundColor(Color(.beigeText)) // Use asset color for text
                            .padding(.top,0.5)
                            .padding(.leading,220)
                    }
                    
                    
                    Button(action: {
                        // Handle login action
                    }) {
                        Text("Login")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.beigeText)
                            .cornerRadius(5)
                            .padding(.horizontal)
                        
                        }
                    Spacer()
                    
                    
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden()) {
                        Text("Sign Up")
                            .foregroundColor(.beigeText)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.newbackground)
                            .border(Color.beigeText, width: 2)
                            .cornerRadius(5)
                            .padding(.horizontal)
                    }
                        
                    }
                    
                }
                navigationBarHidden(true)
            }
        }
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }


