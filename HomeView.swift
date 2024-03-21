//
//  HomeView.swift
//  Prometheus
//
//  Created by Noah DeMent on 3/18/24.
//

import Foundation
import SwiftUI
import FirebaseCore

struct HomeView: View {
    @StateObject private var dataManager = DataManager()
    @State private var firstName: String = "Loading..."
    
    var body: some View {
        VStack {
            Text("Hello, \(firstName)!") // Display the user's first name here
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .onAppear {
            if let user = dataManager.users.first {
                firstName = user.firstName
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
