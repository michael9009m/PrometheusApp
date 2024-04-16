
//
//  Created by Abigail Abeyta on 3/21/24.

import SwiftUI
import Firebase

struct ForgotView: View {
    @State private var email: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(.newbackground)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    NavigationLink(destination:LoginView().navigationBarBackButtonHidden()) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(Color(.beigeText)) // Use asset color for text
                            .padding(.trailing,300.0)
                            
                    }
                    
                    Text("Forgot Password?")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .padding(.top, 40)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, 70.0)
                    
                        
                    

                    Text("Enter your email address below and we'll send you a password reset link.")
                        .font(.title2)
                        .fontWeight(.thin)
                        .foregroundColor(Color(.white))
                        .padding(.bottom, 50)
                        .multilineTextAlignment(.leading)
                        .padding()

                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                        .padding(.horizontal, 30)

                    Spacer()

                    Button(action: {
                        resetPassword()
                    }) {
                        Text("Send Reset Email")
                            .padding()
                            .foregroundColor(.greyText)
                            .frame(maxWidth: .infinity)
                            .background(Color.beigeText)
                            .cornerRadius(8)
                            .padding(.horizontal, 30)
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Forgot Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error resetting password: \(error.localizedDescription)")
                self.alertMessage = "Failed to send reset email. \(error.localizedDescription)"
            } else {
                print("Password reset email sent successfully")
                self.alertMessage = "Password reset email sent successfully. Please check your email inbox."
                // Clear the email field after successful submission
                self.email = ""
            }
            self.showAlert = true
        }
    }
}

struct ForgotView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotView()
    }
}
