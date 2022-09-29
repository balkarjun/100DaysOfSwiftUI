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
    @State private var selectedOption = Int.random(in: 2...13)
    @State private var questions = [Int]()
    @State private var currentQuestion = 0
    
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
                                        selectedOption == number ? Color.yellow : Color.orange
                                        
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
                    for _ in 1...numberOfQuestions {
                        questions.append(Int.random(in: 2...13))
                    }
                }
            }
            .padding()
        } else {
            VStack {
                Button("Restart") {
                    isPlaying = false
                    questions.removeAll()
                    currentQuestion = 0
                }
                Text("Playing with \(numberOfQuestions) questions for \(selectedOption)")
                
                Text("\(selectedOption)x\(questions[currentQuestion])=?")
                
                ForEach(generateOptions(), id: \.self) { value in
                    Button("\(value)") {
                        if value == selectedOption * questions[currentQuestion] {
                            // DEBUG: correct answer
                            print("Correct Answer")
                        } else {
                            // DEBUG: wrong answer
                            print("Wrong Answer")
                        }
                    }
                }
                
                if currentQuestion == numberOfQuestions - 1 {
                    Text("Finished!")
                }
                
                Button("Next Question") {
                    if currentQuestion < numberOfQuestions - 1 {
                        currentQuestion += 1
                    }
                }
            }
        }
    }
    
    func generateOptions() -> [Int] {
        var options = [Int]()
        options.append(selectedOption * questions[currentQuestion])
        
        for _ in 1...3 {
            let value = selectedOption * Int.random(in: 1...13)
            options.append(value)
        }
        return options
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
