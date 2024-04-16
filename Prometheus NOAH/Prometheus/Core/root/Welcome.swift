import SwiftUI



struct Welcome: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background-Image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        VStack {
                            Spacer()
                            NavigationLink(destination: SignUpView().navigationBarBackButtonHidden()) {
                                Text("Sign Up")
                                    .foregroundColor(.greyText) // Change text color to red
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 250.0, height: 50)
                                    .background(Color.white) // Change background color to white
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2) // Add red border
                                    )
                            }
                            .padding(.top, 600.0)

                            NavigationLink(destination: LoginView().navigationBarBackButtonHidden()) {
                                Text("Log In")
                                    .foregroundColor(.greyText) // Change text color to red
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color.white) // Change background color to white
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2) // Add red border
                                    )
                            }
                            Spacer()
                        }
                    )
                    .overlay(
                        VStack {
                            Text("Prometheus")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        }
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 200)
                    )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
//import SwiftUI
//
//struct Welcome: View {
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("Background-Image")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .overlay(
//                        VStack {
//                            Spacer()
//                            NavigationLink(destination: SignUpView().navigationBarBackButtonHidden()) {
//                                Text("Sign Up")
//                                    .foregroundColor(.greyText)
//                                    .font(.headline)
//                                    .padding()
//                                    .frame(width: 250.0, height: 50)
//                                    .background(Color.white)
//                                    .cornerRadius(10)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.white, lineWidth: 2)
//                                    )
//                            }
//                            .padding(.bottom, 16) // Adjust the padding here if needed
//                            
//                            NavigationLink(destination: LoginView().navigationBarBackButtonHidden()) {
//                                Text("Log In")
//                                    .foregroundColor(.greyText)
//                                    .font(.headline)
//                                    .padding()
//                                    .frame(width: 250, height: 50)
//                                    .background(Color.white)
//                                    .cornerRadius(10)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.white, lineWidth: 2)
//                                    )
//                            }
//                            Spacer()
//                        }
//                        .padding(.top, 200) // Adjust the padding here if needed
//                    )
//                    .overlay(
//                        VStack {
//                            Text("Prometheus")
//                                .font(.largeTitle)
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color.white)
//                        }
//                        .multilineTextAlignment(.center)
//                        .padding(.bottom, 50) // Adjust the padding here if needed
//                    )
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Welcome()
//    }
//}
