//
//  ContentView.swift
//  C01-Convert
//
//  Created by Arjun B on 27/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 12.0
    @State private var inputUnit = "C"
    @State private var outputUnit = "K"
    
    let units = ["C", "F", "K"]
    
    var output: String {
        var value = inputValue
        // convert input to celsius
        if inputUnit == "F" {
            value = (value - 32.0)/1.8
        } else if inputUnit == "K" {
            value = value - 273.15
        }
        // convert from celsius to output unit
        if outputUnit == "F" {
            value = 32.0 + value * 1.8
        } else if outputUnit == "K" {
            value = value + 273.15
        }
        
        return String(format: "%.2f", value)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Input", value: $inputValue, format: .number)
                            .padding(.leading)
                        
                        Divider()
                        
                        Picker("From", selection: $inputUnit) {
                            ForEach(units, id: \.self) {
                                Text("°\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal)
                    }
                } header: {
                    Text("Temperature to Convert")
                }
                
                Section {
                    Text(output)
                        .bold()
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Picker("To", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("°\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.portrait)
            ContentView()
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
