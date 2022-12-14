//
//  ContentView.swift
//  C02-RPS
//
//  Created by Arjun B on 01/09/22.
//

import SwiftUI

struct Overlay: View {
    var isCorrect: Bool
    
    var body: some View {
        let color: Color = isCorrect ? .green : .red
        let imageName: String = isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill"
        
        ZStack {
            color
                .opacity(0.5)
                .cornerRadius(10)
            
            Image(systemName: imageName)
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundColor(.white)
                .background(color)
                .clipShape(Circle())
        }
    }
}

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
    
    @State private var isAnswerCorrect = false
    @State private var tappedChoice = 0
    
    var scoreColor: Color {
        if score == 0 {
            return .secondary
        }
        
        return (score < 0) ? .red : .green
    }
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 0) {
                HStack {
                    Text("SCORE")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("QUESTION")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                }
                .padding(.top, 24)
        
                HStack {
                    Text(score, format: .number)
                        .font(.title)
                        .bold()
                        .foregroundColor(scoreColor)
                    
                    Spacer()
                    
                    Text("\(questionNumber) of 10")
                        .font(.title2)
                        .bold()
                }
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .cornerRadius(8)
            
            images[question]
                .resizable()
                .padding(36)
                .frame(width: 180, height: 180)
                .shadow(radius: 5)
                .background(colors[question].opacity(0.9))
                .clipShape(Circle())

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
                                    isAnswerCorrect = true
                                } else {
                                    isAnswerCorrect = false
                                }
                            } else {
                                if options[choice] == loseChoices[question] {
                                    isAnswerCorrect = true
                                } else {
                                    isAnswerCorrect = false
                                }
                            }
                            
                            if isAnswerCorrect {
                                score += 10
                            } else {
                                score -= 10
                            }
                            
                            tappedChoice = choice
                            showNextButton = true
                        } label: {
                            images[choice]
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(16)
                                .shadow(radius: 5)
                                .background(colors[choice].opacity(0.9))
                                .cornerRadius(10)
                                .overlay((showNextButton && choice == tappedChoice) ? Overlay(isCorrect: isAnswerCorrect) : nil)
                        }
                        .disabled(showNextButton)
                    }
                }
            }

            HStack {
                Button {
                    shouldReset = true
                } label: {
                    Image(systemName: "repeat")
                        .font(.body.bold())
                        .padding(10)
                }
                .buttonStyle(.bordered)
                .foregroundColor(.teal)
                
                Button {
                    if questionNumber == 10 {
                        endGame = true
                    } else {
                        showNextButton = false
                        nextQuestion()
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .frame(maxWidth: .infinity)
                        .font(.body.bold())
                        .padding(10)
                }
                .disabled(!showNextButton)
                .buttonStyle(.borderedProminent)
                .tint(.teal)
            }
        }
        .padding(.horizontal, 20)
        .alert("Game Complete", isPresented: $endGame) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("Your Final Score is \(score)")
        }
        .alert("Reset Game?", isPresented: $shouldReset) {
            Button("Yes", action: resetGame)
            Button("No", role: .cancel) {}
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
