//
//  ContentView.swift
//  C03-MultiTap
//
//  Created by Arjun B on 27/09/22.
//

import SwiftUI

struct OptionCard: View {
    var number: Int
    
    var body: some View {
        ZStack {
            Color.orange
            Text(number, format: .number)
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Grid() {
                GridRow {
                    OptionCard(number: 2)
                    OptionCard(number: 3)
                    OptionCard(number: 4)
                }
                GridRow {
                    OptionCard(number: 5)
                    OptionCard(number: 6)
                    OptionCard(number: 7)
                }
                GridRow {
                    OptionCard(number: 8)
                    OptionCard(number: 9)
                    OptionCard(number: 10)
                }
                GridRow {
                    OptionCard(number: 11)
                    OptionCard(number: 12)
                    OptionCard(number: 13)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
