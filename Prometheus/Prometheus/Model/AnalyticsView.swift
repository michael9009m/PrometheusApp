import SwiftUI
import Firebase

struct AnalyticsView: View {
    @State private var userName = "Jane Doe"
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(.newbackground)
                    .edgesIgnoringSafeArea(.top)
                
                ScrollView {
                    VStack {
                        Text("Activity Summary")
                            .font(.largeTitle)
                            .foregroundColor(.beigeText)
                            .fontWeight(.semibold)
                            .padding(.trailing, 100)
                        Divider()
                        
                        Text("Welcome back \n" + userName + "!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.beigeText)
                            .padding(.trailing, 165)
                        
                        // Summary Section
                        ZStack{
                            Rectangle()
                                .frame(width: 350, height: 200)
                                .foregroundColor(.secondary)
                                .cornerRadius(10)
                            
                            Circle()
                                .scale(0.80)
                                .foregroundColor(.white)
                                .padding(.trailing, -140.0)
                            Circle()
                                .scale(0.70)
                                .foregroundColor(.newbackground)
                                .padding(.trailing, -140.0)
                            Circle()
                                .scale(0.60)
                                .foregroundColor(.secondary)
                                .padding(.trailing, -140.0)
                                .shadow(radius: 15)
                            
                            Image(systemName: "figure.run.square.stack.fill")
                                .padding()
                                .font(.system(size: 50))
                                .padding(.leading,140)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        
                        HStack{
                            Text("Steps Taken: 5000")
                                .padding(.top)
                                .foregroundColor(.white)
                            Divider()
                            Text("Distance: 2.5 miles")
                                .padding(.top)
                                .foregroundColor(.white)
                        }
                        VStack {
                            // Additional content here
                        }
                        Divider().padding()
                        
                        // Workout History Section (Placeholder)
                        VStack {
                            Text("Workout History")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 180.0)
                                .font(.system(size: 20))
                                .font(.body)
                                .foregroundColor(.white)
                            
                            // Placeholder for displaying workout history
                            Text("No workout history yet.")
                                .foregroundColor(.gray)
                                .padding(.top, 10)
                        }
                        .padding()
                        
                        Divider().padding()
                        
                        // Trainer Tips Section (Placeholder)
                        VStack {
                            Text("Trainer Tips")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 220.0)
                                .font(.system(size: 20))
                                .font(.body)
                                .foregroundColor(.white)
                            Spacer().padding()
                            
                            NavigationLink(destination: CalorieBMRView().navigationBarBackButtonHidden()) {
                                Text("BMR Calculator")
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(Color.beigeText)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                    }
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

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
