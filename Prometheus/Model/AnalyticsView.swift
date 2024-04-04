//
//  AnalyticsView.swift
//  Prometheus
//
//  Created by Abigail Abeyta on 3/21/24.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(.white).edgesIgnoringSafeArea(.all)
                
                    ZStack{
                        Rectangle()
                            .frame(width: 400, height: 170)
                            .foregroundColor(.newbackground)
                            .cornerRadius(10)
                            .padding(.top,-320)
                        
                    }
                VStack{
                    Text("Welcome back, ")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.beigeText)
                        .padding(.top, -225)
                        .padding(.leading, -160)
                    
                }
                Rectangle()
                    .frame(width: 350, height: 250)
                    .cornerRadius(5.0)
                    .foregroundColor(.brand)
                    .opacity(0.4)
                ZStack{
                    Circle()
                        .scale(0.43)
                        .foregroundColor(.greyText)
                    Circle()
                        .scale(0.38)
                        .foregroundColor(.white)
                    
                    Text("Calories\n  1,200")
                    
                }
                .padding(.leading, -100)
            }
            .padding(.top,-250)
            
        }
        
    }
    
}

#Preview {
    AnalyticsView()
}
