import SwiftUI
import Firebase

struct SettingsView: View {
    
    enum Tab: Int, Identifiable {
        case myInfo, help, settings, signOut
        
        var id: Int {
            self.rawValue
        }
    }
    
    @State private var selectedTab: Tab?
    
    
    var body: some View {
        
        ZStack{
            Color(.newbackground).edgesIgnoringSafeArea(.all)
            
            
            VStack(alignment: .leading, spacing: 20) {
                
                
                TabButton(title: "My Info", isSelected: selectedTab == .myInfo) {
                    selectedTab = .myInfo
                }
                .padding()
                .foregroundColor(.black)
                .frame(width: 300)
                .background(Color.beigeText)
                .cornerRadius(8)
                
                TabButton(title: "Help", isSelected: selectedTab == .help) {
                    selectedTab = .help
                    
                }
                .padding()
                .foregroundColor(.black)
                .frame(width: 300)
                .background(Color.beigeText)
                .cornerRadius(8)
                
                TabButton(title: "Settings", isSelected: selectedTab == .settings) {
                    selectedTab = .settings
                }
                .padding()
                .foregroundColor(.black)
                .frame(width: 300)
                .background(Color.beigeText)
                .cornerRadius(8)
                
                TabButton(title: "Sign Out", isSelected: selectedTab == .signOut) {
                    selectedTab = .signOut
                }
                .padding()
                .foregroundColor(.black)
                .frame(width: 300)
                .background(Color.beigeText)
                .cornerRadius(8)
                
                
            }
            
            
            .padding()
            .sheet(item: $selectedTab) { tab in
                switch tab {
                case .myInfo:
                    MyInfoView(selectedTab: $selectedTab)
                case .help:
                    HelpView(selectedTab: $selectedTab)
                case .settings:
                    SettingsDetailView(selectedTab: $selectedTab)
                case .signOut:
                    SignOutView(selectedTab: $selectedTab)
                }
            }
            
        }
        
    }
}


struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .greyText : .black)
            
        }
        
    }
    
}

// Example content views for each tab
struct MyInfoView: View {
    @State private var userName = "Jane Doe"
    @State private var userEmail = "JaneD@gmail.com" // Default value
    @State private var userAge = "56" // Default value
    @State private var userWeight = "123"
    @State private var userHeight = "5'6"
    
    
    
    
    
    @Binding var selectedTab: SettingsView.Tab?
    @State private var userData: [String: Any] = [:] // State to store user data
    
    var body: some View {
        ZStack {
            Color(.textBox).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("My Info Content")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Divider()
                Text(userName) // Display user's name to the profile page
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.beigeText)
                
                Divider()
                Text(userEmail) // Display user's name to the profile page
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.beigeText)
                Divider()
                Text(userAge + " Years old") // Display user's name to the profile page
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.beigeText)
                Divider()
                Text(userWeight + " lbs") // Display user's name to the profile page
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.beigeText)
                Divider()
                Text(userHeight) // Display user's name to the profile page
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.beigeText)
                
                
               
               
                
                // Button to go back to menu
                Button("Back to Menu") {
                    selectedTab = nil
                }
                .padding()
                .font(.subheadline)
                .foregroundColor(.white)
                .background(Color.newbackground)
                .cornerRadius(8)
            }
        }
        .onAppear {
            fetchUserData()
        }
    }
    
    // Function to fetch user data from UserManager
    private func fetchUserData() {
        if let userID = Auth.auth().currentUser?.uid {
            UserManager.shared.getUserData(userID: userID) { userData in
                if let fullName = userData["fullName"] as? String {
                    self.userName = fullName // Update userName with fetched full name
                }
                if let email = userData["email"] as? String {
                    self.userEmail = email // Update userEmail with fetched email
                }
                if let age = userData["age"] as? String {
                    self.userAge = age // Update userAge with fetched age
                }
                if let weight = userData["weight"] as? String {
                    self.userWeight = weight // Update userWeight with fetched weight
                }
                if let heightFeet = userData["heightFeet"] as? String, let heightInches = userData["heightInches"] as? String {
                    let height = "\(heightFeet) ft \(heightInches) in"
                    self.userHeight = height // Update userHeight with fetched height
                }
            }
        }
    }
}

struct HelpView: View {
    @Binding var selectedTab: SettingsView.Tab?
    
    var body: some View {
        ZStack{
            Color(.textBox).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Help Content")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Divider()
                
                Text("Report a problem")
                
                Button("Back to Menu") {
                    
                    selectedTab = nil
                    
                    
                }
                .padding()
                .font(.subheadline)
                .foregroundColor(.white)
                .background(Color.beigeText)
                .cornerRadius(8)
            }
        }
    }
}

struct SettingsDetailView: View {
    @Binding var selectedTab: SettingsView.Tab?
    
    var body: some View {
        ZStack{
            Color(.textBox).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Settings Detail Content")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Divider()
                Text("new")
                Button("Back to Menu") {
                    selectedTab = nil
                }
                .padding()
                .font(.subheadline)
                .foregroundColor(.white)
                .background(Color.newbackground)
                .cornerRadius(8)
            }
        }
    }
}

struct SignOutView: View {
    @Binding var selectedTab: SettingsView.Tab?
    
    var body: some View {
        ZStack{
            Color(.textBox).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Sign Out Content")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Divider()
                Text("new")
                Button("Back to Menu") {
                    selectedTab = nil
                }
                .padding()
                .font(.subheadline)
                .foregroundColor(.white)
                .background(Color.newbackground)
                .cornerRadius(8)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
