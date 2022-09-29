//
//  ContentView.swift
//  C03-MultiTap
//
//  Created by Arjun B on 27/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfQuestions = 5
    @State private var isPlaying = false
    @State private var selectedOption = -1
    
    var body: some View {
        if (!isPlaying){
            VStack {
                Grid() {
                    ForEach(0..<4) { row in
                        GridRow {
                            ForEach(0..<3) { col in
                                let number = (3 * row) + col + 2
                                
                                Button {
                                    selectedOption = number
                                } label : {
                                    ZStack {
                                        Color.orange
                                        Text(number, format: .number)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Stepper("Number of Questions: \(numberOfQuestions)", value: $numberOfQuestions, in: 5...20, step: 5)
                
                Button("Play") {
                    isPlaying = true
                }
            }
            .padding()
        } else {
            VStack {
                Button("Restart") {
                    isPlaying = false
                }
                Text("Playing with \(numberOfQuestions) questions")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
