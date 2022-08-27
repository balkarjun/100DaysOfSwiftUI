//
//  ContentView.swift
//  P01-WeSplit
//
//  Created by Arjun B on 27/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        return (1.0 + Double(tipPercentage)/100.0) * checkAmount
    }
    
    var amountPerPerson: Double {
        return totalAmount / Double(numberOfPeople)
    }
    
    let currencyCode = Locale.current.currencyCode ?? "USD"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: currencyCode))
                        .frame(maxWidth: .infinity, alignment: .center)
                } header: {
                    Text("Grand Total")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    Text(amountPerPerson, format: .currency(code: currencyCode))
                        .bold()
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                } header: {
                    Text("Amount Per Person")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
