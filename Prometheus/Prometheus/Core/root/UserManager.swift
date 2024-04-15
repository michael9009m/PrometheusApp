//
//  UserManager.swift
//  Prometheus
//
//  Created by Abigail Abeyta on 4/14/24.
//

import Foundation
import Firebase

struct UserManager {
    static let shared = UserManager()
    
    private let db = Firestore.firestore()
    
//Manages all user data from SignUpView and BMRView to firebase
    
    func createUserDataDocument(userID: String, email: String, firstName: String, lastName: String) {
            let fullName = "\(firstName) \(lastName)"
            
            db.collection("Users").document(userID).setData([
                "email": email,
                "fullName": fullName,
                "date_created": Timestamp()
            ]) { error in
                if let error = error {
                    print("Error creating user data document: \(error.localizedDescription)")
                } else {
                    print("User data document created successfully")
                }
            }
        }
    
    func updateUserData(userID: String, firstName: String, lastName: String, age: String, gender: String, weight: String, heightFeet: String, heightInches: String, activityLevel: String, goal: String) {
            let fullName = "\(firstName) \(lastName)"
            
            db.collection("Users").document(userID).setData([
                "fullName": fullName,
                "age": age,
                "gender": gender,
                "weight": weight,
                "heightFeet": heightFeet,
                "heightInches": heightInches,
                "activityLevel": activityLevel,
                "goal": goal
            ], merge: true) { error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                } else {
                    print("User data updated successfully")
                }
            }
        }
    
    

    
    private func calculateTotalHeightInches(feet: String, inches: String) -> Int {
        guard let feet = Int(feet), let inches = Int(inches) else {
            return 0
        }
        return feet * 12 + inches
    }
    // Modify the function to match the expected argument type
       func getUserData(userID: String, completion: @escaping ([String: Any]) -> Void) {
           db.collection("Users").document(userID).getDocument { document, error in
               if let document = document, document.exists {
                   let userData = document.data() ?? [:]
                   completion(userData)
               } else {
                   print("User document does not exist")
               }
           }
       }
   }

