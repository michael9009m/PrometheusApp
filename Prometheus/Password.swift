import SwiftUI

struct SignUpView: View {
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var passwordValidations: [Bool] = [false, false, false, false, false]

    var body: some View {
        VStack {
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Check password requirements
                if isValidPassword(password) {
                    // Valid password
                    errorMessage = nil
                } else {
                    // Invalid password, set error message
                    errorMessage = "Password must be at least 8 characters long, contain one capital letter, one number, one special character, and one lowercase letter."
                }
            }) {
                Text("Create Account")
            }
            .padding()
            
            // Display error message with dynamic color
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(validPassword() ? .green : .red)
                    .padding()
            }
        }
        .padding()
    }
    
    // Function to check password requirements
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    // Function to check each password requirement separately
    func validPassword() -> Bool {
        return passwordValidations.allSatisfy { $0 }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}