//
//  MessageView.swift
//  Prometheus
//
//  Created by Abigail Abeyta on 4/4/24.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color(.newbackground)
                    .edgesIgnoringSafeArea(.all)
                HStack{
                    Text("Messages")
                        .padding(.top, -360)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
//                        .padding(.horizontal, 80)
                    
                    
                }
                    
                    
                    VStack {
                        NavigationLink(destination:SocialView().navigationBarBackButtonHidden()) {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(Color(.beigeText)) // Use asset color for text
                                .padding(.trailing,300.0)
                        }
                        
                        
                        
                        // Custom nav bar
                        HStack {
                            Spacer()
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                            
                            
                               
                        }
                        .padding()
                        
                        ScrollView {
                            ForEach(0..<15, id: \.self) { num in
                                // Example message content
                                MessageRow(username: "Username", message: "Message sent", date: "22d")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
    
    
    struct MessageRow: View {
        var username: String
        var message: String
        var date: String
        
        var body: some View {
            VStack {
                HStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.beigeText)
                    
                    VStack(alignment: .leading) {
                        Text(username)
                        Text(message)
                    }
                    
                    Spacer()
                    Text(date)
                        .font(.system(size: 14, weight: .semibold))
                }
                Divider()
            }
            .padding(.horizontal)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
