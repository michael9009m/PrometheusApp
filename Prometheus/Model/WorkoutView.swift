import SwiftUI

struct WorkoutView: View {
    var body: some View {
        NavigationView{
            VStack{
//                NavigationLink(destination:QuestionWeightView()) {
//                    Text("quiz")
//                        .foregroundColor(.beigeText) // Change text color to red
//                        .font(.headline)
//                        .padding()
//                        .frame(width: 250.0, height: 50)
//                        .background(Color.newbackground) // Change background color to white
//                        .cornerRadius(10)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.white, lineWidth: 2) // Add red border
//                        )
//                }
                
            }
        }
    }
}

struct ExploreView: View {
    var body: some View {
        Text("Explore Page")
    }
}

struct MyRoutinesView: View {
    var body: some View {
        Text("My Routines Page")
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}


