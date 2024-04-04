import SwiftUI

struct SocialMediaPost: Identifiable {
    let id = UUID()
    let username: String
    let postContent: String
    let image: String
}

struct FitnessSocialMediaView: View {
    let posts: [SocialMediaPost] = [
        SocialMediaPost(username: "fit_life_101", postContent: "Just finished a great workout! 💪", image: "workout_image1"),
        SocialMediaPost(username: "health_freak", postContent: "Healthy eating is key to fitness success! 🥗", image: "food_image1"),
        SocialMediaPost(username: "running_guru", postContent: "Morning run to start the day right! 🏃‍♂️", image: "running_image1"),
        SocialMediaPost(username: "yoga_lover", postContent: "Yoga helps me find balance in life. 🧘‍♀️", image: "yoga_image1"),
        SocialMediaPost(username: "strength_training", postContent: "Lifting weights and feeling strong! 💪", image: "weightlifting_image1")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(posts) { post in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                            Text(post.username)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        Text(post.postContent)
                            .font(.body)
                            .foregroundColor(.white)
                        Image(post.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.5)) // Adjust opacity here
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct SocialView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.darkGray)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        NavigationLink(destination: AccountView()) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    FitnessSocialMediaView()
                }
            }
            .navigationBarTitle("Fitness Social", displayMode: .inline)
            .foregroundColor(.white)
        }
    }
}

struct AccountView: View {
    var body: some View {
        Text("User Account")
            .foregroundColor(.white)
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
