import SwiftUI

struct CalorieBMRView: View {
    @State private var age = ""
    @State private var isMale = false
    @State private var isFemale = false
    @State private var weight = ""
    @State private var heightFeet = ""
    @State private var heightInches = ""
    
    
    @State private var bmr: Double?
    
    var body: some View {
        ZStack{
            Color.black
            Color(.newbackground).edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    Text("FitTips")
                        .font(.largeTitle)
                        .foregroundColor(.beigeText)
                        .fontWeight(.semibold)
                        .padding(.trailing, 230)
                    Divider()
                        .padding()
                    
                    DisclosureGroup("BMR Calculator", content: {
                        Text("Our BMR Calculator helps you estimate your Basal Metabolic Rate, the calories your body needs at rest. Just enter your age, gender, weight, and height to get an idea of the calories you burn daily.")
                            .font(.body)
                            .foregroundColor(.beigeText)
                            .padding()
                    })
                    .font(.largeTitle)
                    .foregroundColor(.beigeText)
                    .fontWeight(.semibold)
                    .padding(.trailing, 10)
                    
                    
                    TextField("Age", text: $age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            isMale = true
                            isFemale = false
                        }) {
                            Text("Male")
                                .foregroundColor(isMale ? .black : .beigeText)
                                .padding()
                                .background(isMale ? Color.beigeText : Color.clear)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.beigeText, lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            isMale = false
                            isFemale = true
                        }) {
                            Text("Female")
                                .foregroundColor(isFemale ? .black : .beigeText)
                                .padding()
                                .background(isFemale ? Color.beigeText : Color.clear)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.beigeText, lineWidth: 1)
                                )
                        }
                    }
                    .padding()
                    
                    TextField("Weight (lbs)", text: $weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                    
                    HStack {
                        TextField("Feet", text: $heightFeet)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .padding()
                        
                        TextField("Inches", text: $heightInches)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .padding()
                    }
                    
                    Button(action: {
                        // Calculate BMR
                        bmr = calculateBMR()
                    }) {
                        Text("Calculate BMR")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.beigeText)
                            .cornerRadius(8)
                    }
                    
                    // Display calculated BMR
                    if let bmr = bmr {
                        Text("Basal Metabolic Rate (BMR): \(bmr, specifier: "%.2f") kcal/day")
                            .foregroundColor(.beigeText)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .padding()
                        
                        
                        
                    }
                        
                    
                    Divider()
                    DisclosureGroup("Zigzag Calorie Cycling", content: {
                        Text("Zigzag calorie cycling prevents weight loss plateaus by alternating between higher and lower calorie intake days, counteracting the body's adaptive tendencies to a consistent calorie deficit.")
                            .font(.body)
                            .foregroundColor(.beigeText)
                            .padding()
                    })
                    .font(.largeTitle)
                    .foregroundColor(.beigeText)
                    .fontWeight(.semibold)
                    .padding(.trailing, 10)
                }
                .padding()
                
                NavigationLink(destination: AnalyticsView().navigationBarBackButtonHidden()) {
                    Text("Done")
                        .padding()
                        .foregroundColor(.black)
                        .frame(width: 300)
                        .background(Color.beigeText)
                        .cornerRadius(8)
                }
            }
            
            
        }
        
    }
    
    
    func calculateBMR() -> Double {
        // Convert weight to kg
        let weightKg = Double(weight) ?? 0 / 2.205
        
        // Convert height to cm
        let feet = Double(heightFeet) ?? 0
        let inches = Double(heightInches) ?? 0
        let heightInInches = feet * 12 + inches
        let heightCm = heightInInches * 2.54
        
        // Convert age to Double
        let ageValue = Double(age) ?? 0
        
        // Calculate BMR using Mifflin-St Jeor Equation
        var bmr: Double
        if isMale {
            bmr = 10 * (weightKg/2.205) + 6.25 * heightCm - 5 * ageValue + 5
        } else if isFemale {
            bmr = 10 * (weightKg/2.205) + 6.25 * heightCm - 5 * ageValue - 161
        } else {
            bmr = 0 // Set default value if gender is not selected
        }
        
        return bmr
    }
}

struct CalorieBMRView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieBMRView()
    }
}
