//
//  ContentView.swift
//  C03-MultiTap
//
//  Created by Arjun B on 27/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isPlaying = true
    @State private var numberOfQuestions = 5
    
    @State private var selectedLHS = Int.random(in: 2...13)
    // DEBUG
    @State private var RHS = [3, 5, 2, 8, 4]
    // @State private var RHS = [Int]()
    @State private var currentRHSIndex = 0
    
    var body: some View {
        if (!isPlaying){
            VStack {
                Grid() {
                    ForEach(0..<4) { row in
                        GridRow {
                            ForEach(0..<3) { col in
                                let number = (3 * row) + col + 2
                                
                                Button {
                                    selectedLHS = number
                                } label : {
                                    ZStack {
                                        selectedLHS == number ? Color.yellow : Color.orange
                                        
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
                    
                    var preValue = 0
                    var newValue: Int
                    for _ in 1...numberOfQuestions {
                        // avoid consecutive duplicates
                        repeat {
                            newValue = Int.random(in: 2...13)
                        } while (newValue == preValue)
                        preValue = newValue
                        
                        RHS.append(newValue)
                    }
                }
            }
            .padding()
        } else {
            VStack {
                Button("Restart") {
                    isPlaying = false
                    RHS.removeAll()
                    currentRHSIndex = 0
                }
                Text("Playing with \(numberOfQuestions) question for \(selectedLHS)")
                
                Text("\(selectedLHS)x\(RHS[currentRHSIndex])=?")
                
                ForEach(generateOptions(), id: \.self) { value in
                    Button("\(value)") {
                        if value == selectedLHS * RHS[currentRHSIndex] {
                            // DEBUG: correct answer
                            print("Correct Answer")
                        } else {
                            // DEBUG: wrong answer
                            print("Wrong Answer")
                        }
                    }
                }
                
                if currentRHSIndex == numberOfQuestions - 1 {
                    Text("Finished!")
                }
                
                Button("Next Question") {
                    if currentRHSIndex < numberOfQuestions - 1 {
                        currentRHSIndex += 1
                    }
                }
            }
        }
    }
    
    func generateOptions() -> [Int] {
        var options = [Int]()
        options.append(selectedLHS * RHS[currentRHSIndex])
        
        for _ in 1...3 {
            // avoid duplicates
            var value: Int
            repeat {
                value = selectedLHS * Int.random(in: 2...13)
            } while (options.contains(value))
            
            options.append(value)
        }
        
        options.shuffle()
        return options
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
