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
    
    @State private var question = Int.random(in: 0...2)
    @State private var toWin = Bool.random()
    
    @State private var score = 0
    
    @State private var showNextButton = false
    
    var body: some View {
        VStack {
            Text(options[question])
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
                        Text("\(options[choice])")
                    }
                    .disabled(showNextButton)
                }
            }
            
            Text(score, format: .number)
            
            Button("Next") {
                nextQuestion()
                showNextButton = false
            }
            .disabled(!showNextButton)
        }
    }
    
    func nextQuestion() {
        question = Int.random(in: 0...2)
        toWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
