import SwiftUI
struct ContentView: View {
    
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
                            NavigationLink(destination: SignUpView().navigationBarBackButtonHidden()) {
                                Text("Sign Up")
                                    .foregroundColor(Color.gray)
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 250.0, height: 50)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
                            }
                            .padding(.top, 600.0)
                            
                            NavigationLink(destination:LoginView()
                                .navigationBarBackButtonHidden()) {
                                Text("Log In")
                                        .foregroundColor(Color.gray)
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 250, height: 50)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
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
            .navigationBarBackButtonHidden()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
