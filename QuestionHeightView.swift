import SwiftUI

struct QuestionHeightView: View {
    @EnvironmentObject var viewModel: SurveyViewModel
    @State private var height: String = ""
    @State private var selectedUnit: HeightUnit = .meters
    
    var body: some View {
        VStack {
            ProgressBar(progress: Float(viewModel.currentQuestionIndex) / 4.0)
                .frame(height: 8)
                .padding(.horizontal)
            Spacer()
            Text("What's your height?")
                .font(.title)
                .foregroundColor(Color.blue)
            
            HStack {
                TextField("Height", text: $height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding()
                
                Picker("Unit", selection: $selectedUnit) {
                    ForEach(HeightUnit.allCases, id: \.self) { unit in
                        Text(unit.rawValue).tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 120)
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
                        // Save height with unit
                        viewModel.userProfile.height = "\(height) \(selectedUnit.rawValue)"
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

enum HeightUnit: String, CaseIterable {
    case meters = "m"
    case feet = "ft"
}
