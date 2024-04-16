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
        SocialMediaPost(username: "health_freak", postContent: "Healthy eating is key to fitness success! 🥗", image: "workout_image2"),
        SocialMediaPost(username: "running_guru", postContent: "Post workout pump! STAY DEDICATED. 🏃‍♂️", image: "workout_image3"),
        SocialMediaPost(username: "yoga_lover", postContent: "Boxing helps me find balance in life. 🧘‍♀️", image: "workout_image4"),
        SocialMediaPost(username: "strength_training", postContent: "Getting in a morning hike! 💪", image: "workout_image5")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(posts) { post in
                    PostView(post: post)
                }
            }
            .padding()
        }
        .background(Color.white)
    }
}

struct PostView: View {
    @State private var isLiked = false
    @State private var likeCount = Int.random(in: 1000...10000)
    @State private var commentCount = Int.random(in: 1000...10000)
    
    let post: SocialMediaPost
    
    var formattedLikeCount: String {
        if likeCount > 5000 {
            let kCount = Double(likeCount) / 1000
            return String(format: "%.1fK", kCount)
        } else {
            return "\(likeCount)"
        }
    }
    
    var formattedCommentCount: String {
        if commentCount > 5000 {
            let kCount = Double(commentCount) / 1000
            return String(format: "%.1fK", kCount)
        } else {
            return "\(commentCount)"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 1) // Add black outline
                    )
                Text(post.username)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            Text(post.postContent)
                .font(.body)
                .foregroundColor(.white)
            ZStack(alignment: .bottomTrailing) {
                Image(post.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            isLiked.toggle()
                            if isLiked {
                                likeCount += 1
                            } else {
                                likeCount -= 1
                            }
                        }) {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isLiked ? .red : .black)
                        }
                        .padding(5)
                        
                        Text(formattedLikeCount)
                            .foregroundColor(.white)
                            .font(.caption)
                            .padding(.trailing, 5)
                        
                        Button(action: {
                            // Handle comment button action
                            commentCount += 1
                        }) {
                            Image(systemName: "bubble.left")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                        .padding(5)
                        
                        Text(formattedCommentCount)
                            .foregroundColor(.white)
                            .font(.caption)
                            .padding(.trailing, 5)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.8)) // Dark gray color with adjusted opacity
        .cornerRadius(10)
    }
}

struct SocialView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("Social Page")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center) // Centered "Social Page"
                    .background(Color.gray.opacity(0.8)) // Dark gray color with adjusted opacity
                
                Spacer().frame(height: 10) // Added some space
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ProfileView()) {
                        Text("My Profile")
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5) // Add vertical padding
                            .background(Color.gray.opacity(0.3)) // Slightly gray background
                            .cornerRadius(5)
                            .padding(.trailing, 10) // Add trailing padding
                    }
                }
                .padding(.bottom, 10) // Add bottom padding
                
                FitnessSocialMediaView()
            }
            .navigationBarTitle("", displayMode: .inline) // Remove the navigation bar title
        }
    }
}

struct AccountView: View {
    var body: some View {
        Text("My Profile")
            .foregroundColor(.white)
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
