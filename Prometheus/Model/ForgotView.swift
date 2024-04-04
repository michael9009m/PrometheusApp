//
//  ForgotView.swift
//  Prometheus
//
//  Created by Abigail Abeyta on 3/21/24.
//
import UIKit
import Firebase
import SwiftUI

struct ForgotView: View {
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.newbackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Forgot Password?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.beigeText)
                        .padding(.top, 30)
                        .padding(.leading, -75)
                    
                    Spacer()
                    
                    Text("If there's an email associated with this account, you will receive an email with a link to reset your password.")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.gray))
                        .padding(.bottom, 100)
                        .multilineTextAlignment(.center)
                    
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Button {
                        ResetP()
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
                    
//                    Button(action: {
//                        // Action to send reset password email
//                    }) {
//                        Text("Send Reset Email")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .cornerRadius(8)
//                            .padding(.horizontal, 30)
//                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    /////FORGOT PASSWORD
    func ResetP() {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email){ (error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }
}

struct ForgotView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotView()
    }
}
