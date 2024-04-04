import SwiftUI

struct HomeView: View {
    var body: some View {
        
        TabView {
            AnalyticsView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            WorkoutView()
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Workout")
                }
            
            SocialView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Social")
                }
        }
        .accentColor(.blue) // Change the accent color of the selected tab item
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
