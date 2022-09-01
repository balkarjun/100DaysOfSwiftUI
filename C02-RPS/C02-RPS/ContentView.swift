//
//  ContentView.swift
//  C02-RPS
//
//  Created by Arjun B on 01/09/22.
//

import SwiftUI

struct ContentView: View {
    let options = ["Rock", "Paper", "Scissor"]
    let winChoices = ["Paper", "Scissor", "Rock"]
    let loseChoices = ["Scissor", "Rock", "Paper"]
    
    let colors: [Color] = [.red, .green, .blue]
    
    let icons = ["Rock" : "✊🏼",
        "Paper": "🖐🏼",
        "Scissor": "✌🏼"]
    
    @State private var question = Int.random(in: 0...2)
    @State private var toWin = Bool.random()
    
    @State private var score = 0
    @State private var questionNumber = 1
    
    @State private var endGame = false
    @State private var showNextButton = false
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()

            VStack {
                Text(icons[options[question]]!)
                    .font(.system(size: 100))
                
                Spacer(minLength: 30)
                
                VStack {
                    Text("CHOOSE TO")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                    Text(toWin ? "Win" : "Lose")
                        .font(.largeTitle)
                        .bold()
                }

                HStack {
                    ForEach(0..<3) { choice in
                        Button {
                            if toWin {
                                if options[choice] == winChoices[question] {
                                    score += 10
                                } else {
                                    score -= 10
                                }
                            } else {
                                if options[choice] == loseChoices[question] {
                                    score += 10
                                } else {
                                    score -= 10
                                }
                            }
                            
                            showNextButton = true
                        } label: {
                            ZStack {
                                colors[choice]
                                    .cornerRadius(8)
                                
                                Color.clear
                                    .background(.regularMaterial)
                                    .cornerRadius(8)
                                
                                Text("\(icons[options[choice]]!)")
                                    .font(.system(size: 80))
                            }
                        }
                        .disabled(showNextButton)
                    }
                }
            }
            
            VStack(spacing: 40) {
                VStack {
                    Text("SCORE")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                    Text(score, format: .number)
                        .font(.largeTitle)
                        .bold()
                }
                
                VStack(spacing: 8) {
                    Text("\(questionNumber) / 10")
                        .bold()
                        .foregroundColor(.teal)
                    
                    Button {
                        if questionNumber == 10 {
                            endGame = true
                            // this means we pressed the next button on the last question.
                        } else {
                            showNextButton = false
                            nextQuestion()
                        }
                    } label: {
                        Text("Next Question")
                            .bold()
                            .padding(.vertical, 8)
                            .padding(.horizontal, 40)
                    }
                    .disabled(!showNextButton)
                    .buttonStyle(.bordered)
                    .tint(.teal)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .alert("Game Complete", isPresented: $endGame) {
            Button("Play Again") {
                score = 0
                questionNumber = 0
                showNextButton = false
                nextQuestion()
            }
        } message: {
            Text("Your Final Score is \(score)")
        }
    }
    
    func nextQuestion() {
        question = Int.random(in: 0...2)
        toWin = Bool.random()
        questionNumber += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
