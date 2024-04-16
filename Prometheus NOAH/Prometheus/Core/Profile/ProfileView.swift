//Tasks: update profile pic, save photos under a users profile, save bio figure out messaging

import SwiftUI
import Firebase

struct ProfileView: View {
    @State private var isEditing = false
    @State private var profilePicture: Image?
    @State private var bio = "add your bio here"
    @State private var userName = "Jane Doe" // Default value
    
    var body: some View {
        ZStack{
            Color(.newbackground)
                .edgesIgnoringSafeArea(.top)
            ScrollView {
                VStack {
                    // User Name with Settings and Messaging Buttons
                    HStack {
                        Button(action: {
                            // Implement settings functionality
                        }) {
                            Image(systemName: "equal")
                                .foregroundColor(.beigeText)
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text("profile")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.beigeText)
                        
                        Spacer()
                        
                        Button(action: {
                            // navigate to MessageView
                        }) {
                            Image(systemName: "message")
                                .foregroundColor(.beigeText)
                        }
                        .padding(.trailing)
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    // Profile Picture and User Info
                    HStack {
                        // Profile Picture
                        if let profilePic = profilePicture {
                            profilePic
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.trailing, 20)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.trailing, 20)
                                .foregroundColor(.beigeText)
                        }
                        
                        // User Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text(userName) // Display user's name to the profile page
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.beigeText)
                            
                            Text("Bio: \(bio)")
                                .font(.body)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Edit Profile Button
                    if isEditing {
                        // Edit Bio
                        TextEditor(text: $bio)
                            .foregroundColor(.black)
                            .frame(height: 100)
                            .padding()
                        
                        // Save Changes Button
                        Button(action: {
                            // Implement save changes functionality
                            isEditing = false // Exit editing mode
                        }) {
                            Text("Save Changes")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.beigeText)
                                .cornerRadius(8)
                        }
                        .padding()
                    } else {
                        // Display "Edit Profile" Button
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Text("Edit Profile")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.beigeText)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            fetchUserData() // Fetch user data when the view appears
        }
    }
    
    // Function to fetch user data
    private func fetchUserData() {
        if let userID = Auth.auth().currentUser?.uid {
            UserManager.shared.getUserData(userID: userID) { userData in
                if let fullName = userData["fullName"] as? String {
                    self.userName = fullName // Update userName with fetched full name
                }
            }
        }
    }
}



    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
