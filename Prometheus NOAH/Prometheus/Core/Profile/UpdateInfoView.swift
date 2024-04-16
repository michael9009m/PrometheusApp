//
//  UpdateInfoView.swift
//  Prometheus
//
//  Created by Noah DeMent on 4/14/24.
//

import SwiftUI
import Firebase

struct UpdateInfoView: View {
    let userID: String
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var weight = ""
    @State private var heightFeet = ""
    @State private var heightInches = ""
    @State private var activityLevel = ""
    @State private var goal = ""
    
    // Gender options
    let genders = ["Female", "Male"]
    @State private var selectedGender = ""
    @State private var navigateToHome = false // State variable to control navigation
    
    // Activity level options
    let activityLevels = ["Low", "Moderate", "Intense"]
    
    // Goal options
    let goals = ["Lose Weight", "Gain Weight", "Build Muscle", "Maintain Weight"]
    
    var body: some View {
        ZStack {
            Color.black
            Color(.newbackground).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("Update Info")
                        .font(.largeTitle)
                        .foregroundColor(.beigeText)
                        .fontWeight(.semibold)
                        .padding(.trailing, 180)
                    Divider()
                    
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Age", text: $age)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
                    // Gender selection
                    Picker(selection: $selectedGender, label: Text("Gender")) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Weight (lbs)", text: $weight)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
                    // Height selection
                    HStack {
                        TextField("Feet", text: $heightFeet)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .foregroundColor(.black)
                        Text("ft")
                            .foregroundColor(.beigeText)
                        Spacer()
                        TextField("Inches", text: $heightInches)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .foregroundColor(.black)
                        Text("in")
                            .foregroundColor(.beigeText)
                    }
                    .foregroundColor(.white)
                    
                    //Fitness Goals Section
                    Text("Fitness goals")
                        .font(.largeTitle)
                        .foregroundColor(.beigeText)
                        .fontWeight(.semibold)
                        .padding(.trailing, 150)
                    Divider()
                    
                    // Activity level selection
                    VStack {
                        Text("Current activity level?")
                            .foregroundColor(.beigeText)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        
                        Picker(selection: $activityLevel, label: Text("Activity Level")) {
                            ForEach(activityLevels, id: \.self) { level in
                                Text(level)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .accentColor(.beigeText)
                    }
                    Divider()
                    
                    // Goal selection
                    VStack {
                        Text("Goal")
                            .foregroundColor(.beigeText)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                        
                        Picker(selection: $goal, label: Text("Goal")) {
                            ForEach(goals, id: \.self) { goalOption in
                                Text(goalOption)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .accentColor(.beigeText)
                    }
                    Divider()
                    
                    // Navigate to HomeView button
                    Button(action: {
                        UserManager.shared.updateUserData(userID: userID, firstName: firstName, lastName: lastName, age: age, gender: selectedGender, weight: weight, heightFeet: heightFeet, heightInches: heightInches, activityLevel: activityLevel, goal: goal) // Call UserManager to update user data
                        navigateToHome = true
                        
                    }) {
                        Text("Save")
                            .padding()
                            .foregroundColor(.greyText)
                            .frame(maxWidth: .infinity)
                            .background(Color.beigeText)
                            .cornerRadius(5)
                            .padding(.horizontal)
                            .padding(.top, 30)
                    }
                    
                    // NavigationLink to HomeView
                    NavigationLink(destination: HomeView().navigationBarBackButtonHidden(), isActive: $navigateToHome) {
                        EmptyView() // Use an EmptyView to hide the NavigationLink
                    }
                    .hidden() // Hide the NavigationLink
                }
                .padding()
            }
        }
    }
}

struct UpdateInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateInfoView(userID: "dummyUserID")
    }
}










