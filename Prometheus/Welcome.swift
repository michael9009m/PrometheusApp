import SwiftUI

extension Color {
    static let greyText = Color.gray
}

struct Welcome: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Background-Image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        VStack {
                            Spacer()
                            NavigationLink(destination: SignUpView()) {
                                Text("Sign Up")
                                    .foregroundColor(.black) // Change text color to black
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 250.0, height: 50)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                    )
                            }
                            .padding(.top, 600.0)

                            NavigationLink(destination: LoginView()) {
                                Text("Log In")
                                    .foregroundColor(.black) 
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
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
