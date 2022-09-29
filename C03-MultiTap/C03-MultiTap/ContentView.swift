//
//  ContentView.swift
//  C03-MultiTap
//
//  Created by Arjun B on 27/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var settingsShown = true
    @State private var numberOfQuestions = 10
    
    @State private var selectedLHS = Int.random(in: 2...13)
    
    @State private var RHS = [Int]()
    @State private var currentRHSIndex = 0
    @State private var wasQuestionAnswered = false
    
    @State private var answerOptions = [Int]()
    
    @State private var score = 0
    
    @State private var selectedAnswerIndex = 0
    
    func isAnswerCorrect(_ idx: Int) -> Bool {
        return answerOptions[idx] == selectedLHS * RHS[currentRHSIndex]
    }
    
    func getOptionColor(_ idx: Int) -> Color {
        if wasQuestionAnswered && selectedAnswerIndex == idx {
            return isAnswerCorrect(idx) ? .green.opacity(0.8) : .red.opacity(0.8)
        }
        return .secondary.opacity(0.15)
    }
    
    func getOptionOpacity(_ idx: Int) -> Double {
        if wasQuestionAnswered {
            if selectedAnswerIndex == idx {
                return 1.0
            }
            return 0.5
        }
        return 1.0
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 2) {
                    Text("SCORE")
                        .font(.monospaced(.body)())
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Text(score, format: .number)
                        .font(.monospaced(.title2)())
                        .bold()
                        .foregroundColor(score == 0 ? .secondary : (score < 0 ? .red : .green))
                }
                
                Spacer()
                
                VStack(spacing: 2) {
                    Text("QUESTION")
                        .font(.monospaced(.body)())
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Text("\(currentRHSIndex + 1) of \(numberOfQuestions)")
                        .font(.monospaced(.title2)())
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
            if !RHS.isEmpty {
                HStack {
                    Text(selectedLHS, format: .number)
                        .font(.monospaced(.system(size: 90))())
                    Text("×")
                        .font(.system(size: 70))
                        .foregroundColor(.secondary)
                    Text(RHS[currentRHSIndex], format: .number)
                        .font(.monospaced(.system(size: 90))())

                }
                .bold()
            }
            Spacer()
            if !answerOptions.isEmpty {
                Grid() {
                    ForEach(0..<2) { row in
                        GridRow {
                            ForEach(0..<2) { col in
                                let idx = 2 * row + col
                                
                                Button() {
                                    wasQuestionAnswered = true
                                    selectedAnswerIndex = idx
                                    
                                    if answerOptions[idx] == selectedLHS * RHS[currentRHSIndex] {
                                        score += 10
                                    } else {
                                        score -= 10
                                    }
                                } label: {
                                    Text(answerOptions[idx], format: .number)
                                        .font(.monospaced(.title2)())
                                        .bold()
                                        .padding(.vertical, 30)
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.primary)
                                }
                                .background(getOptionColor(idx))
                                .opacity(getOptionOpacity(idx))
                                .cornerRadius(8)
                                .disabled(wasQuestionAnswered)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                // restart game
                Button {
                    wasQuestionAnswered = false
                    settingsShown = true
                    RHS.removeAll()
                    currentRHSIndex = 0
                    score = 0
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .bold()
                        .frame(height: 36)
                        .padding(.horizontal)
                }
                .buttonStyle(.bordered)
                .tint(.yellow)
                
                // go to next question
                Button {
                    wasQuestionAnswered = false
                    if currentRHSIndex < numberOfQuestions - 1 {
                        currentRHSIndex += 1
                        answerOptions = generateOptions()
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .bold()
                        .frame(height: 36)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
                .disabled(currentRHSIndex >= numberOfQuestions - 1 || !wasQuestionAnswered)
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 30)
        .sheet(isPresented: $settingsShown) {
            VStack {
                Text("Multiplication Table")
                    .font(.monospaced(.title3)())
                    .bold()
                    .padding(.vertical)
                    .foregroundColor(.secondary)
                
                Grid() {
                    ForEach(0..<4) { row in
                        GridRow {
                            ForEach(0..<3) { col in
                                let number = (3 * row) + col + 2
                                
                                Button {
                                    selectedLHS = number
                                } label : {
                                    Text(number, format: .number)
                                        .font(.monospaced(.title2)())
                                        .bold()
                                        .padding(.vertical, 30)
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(selectedLHS == number ? .primary : .secondary)
                                }
                                .background(selectedLHS == number ? .green.opacity(0.9) : .secondary.opacity(0.05))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                
                VStack {
                    Text("Number of Questions")
                        .font(.monospaced(.title3)())
                        .bold()
                        .padding()
                        .foregroundColor(.secondary)
                    HStack {
                        ForEach(1..<5) { idx in
                            let number = 5 * idx
                            
                            Button {
                                numberOfQuestions = number
                            } label: {
                                Text(number, format: .number)
                                    .font(.monospaced(.title2)())
                                    .bold()
                                    .padding(.vertical, 30)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(numberOfQuestions == number ? .primary : .secondary)
                            }
                            .background(numberOfQuestions == number ? .green.opacity(0.9) : .secondary.opacity(0.05))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.bottom, 30)
                }

                Button {
                    wasQuestionAnswered = false
                    settingsShown = false
                    
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
                    
                    answerOptions = generateOptions()
                } label: {
                    Image(systemName: "forward.fill")
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            .padding()
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
