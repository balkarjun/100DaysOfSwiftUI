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
    let images: [Image] = [Image("rock"), Image("paper"), Image("scissor")]
    
    @State private var question = Int.random(in: 0...2)
    @State private var toWin = Bool.random()
    
    @State private var score = 0
    @State private var questionNumber = 1
    
    @State private var endGame = false
    @State private var shouldReset = false
    @State private var showNextButton = false
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()

            VStack {
                images[question]
                    .resizable()
                    .padding(36)
                    .frame(width: 200, height: 200)
                    .background(colors[question])
                    .clipShape(Circle())
                
                Spacer(minLength: 30)
                
                VStack(spacing: 10) {
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
                                images[choice]
                                    .resizable()
                                    .scaledToFit()
                                    .padding(12)
                                    .background(colors[choice])
                                    .cornerRadius(8)
                            }
                            .disabled(showNextButton)
                        }
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
                        .foregroundColor(score < 0 ? .red : .green)
                }
                
                VStack(spacing: 8) {
                    Text("\(questionNumber) / 10")
                        .bold()
                        .foregroundColor(.teal)
                    
                    HStack {
                        Button {
                            shouldReset = true
                        } label: {
                            Image(systemName: "repeat")
                                .font(.body.bold())
                                .padding(8)
                        }
                        .buttonStyle(.bordered)
                        .tint(.teal)
                        
                        Button {
                            if questionNumber == 10 {
                                endGame = true
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
                        .buttonStyle(.borderedProminent)
                        .tint(.teal)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .alert("Game Complete", isPresented: $endGame) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your Final Score is \(score)")
        }
        .alert("Reset Game?", isPresented: $shouldReset) {
            Button("Yes", action: resetGame)
            Button("Cancel", role: .cancel) {}
        }
    }
    
    func resetGame() {
        score = 0
        questionNumber = 0
        showNextButton = false
        nextQuestion()
    }
    
    func nextQuestion() {
        var newQuestion: Int
        var newToWin: Bool
        // avoid repeat questions
        repeat {
            newQuestion = Int.random(in: 0...2)
            newToWin = Bool.random()
        } while (newQuestion == question && newToWin == toWin)
        
        question = newQuestion
        toWin = newToWin
        
        questionNumber += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
