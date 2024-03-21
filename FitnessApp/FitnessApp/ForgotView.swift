//
//  ForgotView.swift
//  FitnessApp
//
//  Created by Abigail Abeyta on 3/13/24.
//

import SwiftUI

struct ForgotView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(.newbackground).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)//dark background color
                VStack {
                    Text("Forgot Password?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.beigeText)
                        .padding(.top, 30)
                        .padding(.leading, -75)
                    
                }
            }
        }
    }
}


#Preview {
    ForgotView()
}

