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
        VStack {
            Text(icons[options[question]]!)
            Text(toWin ? "Play to Win" : "Play to Lose")
            
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
                        Text("\(icons[options[choice]]!)")
                    }
                    .disabled(showNextButton)
                }
            }
            
            Text(score, format: .number)
            
            Text("Question \(questionNumber) of 10")
            
            Button("Next") {
                if questionNumber == 10 {
                    endGame = true
                    // this means we pressed the next button on the last question.
                } else {
                    showNextButton = false
                    nextQuestion()
                }
            }
            .disabled(!showNextButton)
        }
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
