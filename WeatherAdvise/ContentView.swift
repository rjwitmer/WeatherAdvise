//
//  ContentView.swift
//  WeatherAdvise
//
//  Created by Bob Witmer on 2023-07-24.
//

import SwiftUI

struct ContentView: View {
    @State private var imageName = ""
    @State private var adviceMessage = ""
    @State private var temp = ""
    @State private var isFarenheit = true
    @FocusState private var textFieldIsFocused: Bool
    let appTitle = "Weather Advice"
    
    var body: some View {
        VStack {

            Text(appTitle)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.blue)
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding()
            Text(adviceMessage)
                .font(.largeTitle)
                .frame(height: 80)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            
            HStack {
                
                Text("What is the temp?")
                    .font(.title)
                    .multilineTextAlignment(.leading)

                TextField("", text: $temp)
                    .textFieldStyle(.roundedBorder)
                    .font(.title)
                    .frame(width: 65)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .keyboardType(.numberPad)
                    .onChange(of: temp) { _ in
                        temp = temp.trimmingCharacters(in: .decimalDigits.inverted)
                    }
                    .focused($textFieldIsFocused)
                    .onSubmit {
                        guard temp != "" else {
                            return
                        }
                        giveAdvice(temperature: Int(temp)!)
                    }
                
            }
            
            HStack {
                
                if isFarenheit {
                    Toggle("Farenheit", isOn: $isFarenheit)
                        .frame(width: 130)
                } else {
                    Toggle("Celcius", isOn: $isFarenheit)
                        .frame(width: 130)
                }
                
                Button("Get Advice!") {
                    giveAdvice(temperature: (Int(temp)!))
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .font(.title2)
                .disabled(temp.isEmpty)
                

            }
        }
        .padding()
    }
    
    func giveAdvice( temperature: Int ) {
        var passedTemp: Double = Double(temperature)
        if !isFarenheit {
            passedTemp *= 1.8 + 32
        }
        let farTemp = Int(passedTemp)
        switch farTemp {
        case 76...:
            adviceMessage = "It's Hot"
            imageName = "hot"
        case 63...76:
            adviceMessage = "Nice and Mild"
            imageName = "mild"
        case 45...63:
            adviceMessage = "You're going to need a sweater"
            imageName = "cool"
        case 33...45:
            adviceMessage = "You're going to need a coat"
            imageName = "cold"
        case ...33:
            adviceMessage = "Bundle up, it's freezing"
            imageName = "freezing"
        default:
            adviceMessage = ""
            imageName = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
