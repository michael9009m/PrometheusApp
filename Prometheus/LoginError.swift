import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Perform login authentication here
                if isValidCredentials() {
                    // Successful login
                    errorMessage = nil
                } else {
                    // Invalid credentials, set error message
                    errorMessage = "Invalid username or password"
                }
            }) {
                Text("Login")
            }
            .padding()
            
            // Display error message if present
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
    
    // Dummy function for checking credentials
    func isValidCredentials() -> Bool {
        // Replace this with actual authentication logic
        let validUsername = "user"
        let validPassword = "password"
        return username == validUsername && password == validPassword
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}