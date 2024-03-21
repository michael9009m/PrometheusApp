//  SignUpView.swift
//  FitnessApp
//  Created by Abigail Abeyta on 3/4/24.

import SwiftUI
struct SignUpView: View {
    
    @State private var Username = ""
    @State private var Email = ""
    @State private var Password = ""
    @State private var Birthday = ""
    @State private var ConfirmPassword = ""
    var body: some View {
        
        ZStack {
            Color(.newbackground).edgesIgnoringSafeArea(.all)
            VStack{
                Text("Great! Let's get\nyour info")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.beigeText)
                    .padding(.top, 30)
                    .padding(.leading, -75)
                // For example, you can use TextField for username, email, and password, and a Button for sign up
                
                TextField("Username", text: $Username)
                    .padding()
                    .background(Color.secondary.opacity(0.4))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                TextField("Email", text: $Email)
                    .padding()
                    .background(Color.secondary.opacity(0.4))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                TextField("Date of Birth", text: $Birthday)
                    .padding()
                    .background(Color.secondary.opacity(0.4))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $Password)
                    .padding()
                    .background(Color.secondary.opacity(0.4))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                SecureField("Confirm Password", text: $ConfirmPassword)
                    .padding()
                    .background(Color.secondary.opacity(0.4))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                
                
                Button(action: {
                }) {
                    Text("Sign Up")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.beigeText)
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .padding(.top, 30)
                    
                }
                Spacer()
                
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden()) {
                    Text("Already have an account? Sign in")
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View{
        SignUpView()
    }
}
