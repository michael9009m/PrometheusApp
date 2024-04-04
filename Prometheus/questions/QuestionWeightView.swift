import SwiftUI

struct QuestionWeightView: View {
    @EnvironmentObject var viewModel: SurveyViewModel
    @State private var weight: String = ""
    @State private var selectedUnit: WeightUnit = .kilograms
    
    var body: some View {
        VStack {
            ProgressBar(progress: Float(viewModel.currentQuestionIndex) / 4.0)
                .frame(height: 8)
                .padding(.horizontal)
            Spacer()
            Text("What's your weight?")
                .font(.title)
                .foregroundColor(Color.blue)
            
            HStack {
                TextField("Weight", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                
                Picker("Unit", selection: $selectedUnit) {
                    ForEach(WeightUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
            }
            
            HStack {
                if viewModel.currentQuestionIndex > 0 {
                    Button("Back") {
                        withAnimation {
                            viewModel.currentQuestionIndex -= 1
                        }
                    }
                    .buttonStyle(FilledButton())
                }
                
                Spacer()
                
                Button("Next") {
                    withAnimation {
                        // Save weight with unit
                        viewModel.userProfile.weight = "\(weight) \(selectedUnit.rawValue)"
                        viewModel.currentQuestionIndex += 1
                    }
                }
                .buttonStyle(FilledButton())
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

enum WeightUnit: String, CaseIterable {
    case kilograms = "kg"
    case pounds = "lbs"
}

struct FilledButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
//struct QuestionWeightView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionWeightView()
//    }
//}

