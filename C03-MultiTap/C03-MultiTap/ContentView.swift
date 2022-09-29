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
    @State private var RHS = [7, 3, 2, 8, 4]
    // @State private var RHS = [Int]()
    @State private var currentRHSIndex = 0
    @State private var wasQuestionAnswered = false
    
    @State private var answerOptions = [10, 20, 30, 40, 50]
        
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
                    wasQuestionAnswered = false
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
                HStack {
                    VStack {
                        Text("SCORE")
                            .bold()
                            .foregroundColor(.secondary)
                        
                        Text(80, format: .number)
                            .font(.title2)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("QUESTION")
                            .bold()
                            .foregroundColor(.secondary)
                        
                        Text("\(currentRHSIndex + 1) of \(numberOfQuestions)")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer()
                
                Text("\(selectedLHS) × \(RHS[currentRHSIndex])")
                    .font(.system(size: 80))
                    .bold()
                
                Spacer()
                
                Grid() {
                    ForEach(0..<2) { row in
                        GridRow {
                            ForEach(0..<2) { col in
                                let idx = 2 * row + col

                                Button() {
                                    wasQuestionAnswered = true
                                    if answerOptions[idx] == selectedLHS * RHS[currentRHSIndex] {
                                        print("Correct Answer")
                                    } else {
                                        print("Wrong Answer")
                                    }
                                } label: {
                                    Text(answerOptions[idx], format: .number)
                                        .font(.title2)
                                        .bold()
                                        .padding(.vertical, 30)
                                        .frame(maxWidth: .infinity)
                                }
                                .background(.thinMaterial)
                                .cornerRadius(8)
                                .disabled(wasQuestionAnswered)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    // restart game
                    Button {
                        wasQuestionAnswered = false
                        isPlaying = false
                        RHS.removeAll()
                        currentRHSIndex = 0
                    } label: {
                        Image(systemName: "repeat")
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.bordered)
                    
                    // go to next question
                    Button {
                        wasQuestionAnswered = false
                        if currentRHSIndex < numberOfQuestions - 1 {
                            currentRHSIndex += 1
                            answerOptions = generateOptions()
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(currentRHSIndex >= numberOfQuestions - 1 || !wasQuestionAnswered)
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 30)
        }
    }
    
    func generateOptions() -> [Int] {
        var answers = [Int]()
        answers.append(selectedLHS * RHS[currentRHSIndex])
        
        for _ in 1...3 {
            // avoid duplicates
            var value: Int
            repeat {
                value = selectedLHS * Int.random(in: 2...13)
            } while (answers.contains(value))
            
            answers.append(value)
        }
        
        answers.shuffle()
        return answers
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
