//
//  UserTestView.swift
//  Prometheus
//
//  Created by Noah DeMent on 4/3/24.
//

import SwiftUI

struct UserTestView: View {
    @ObservedObject var userFetcher = UserFetcher()
    
    var userFirstName: String // Assuming you have access to the user's first name
    
    var body: some View {
        Text("Welcome back, \(users.userID.firstName).")
    }
}


#Preview {
    UserTestView(userFirstName: "John")
}
