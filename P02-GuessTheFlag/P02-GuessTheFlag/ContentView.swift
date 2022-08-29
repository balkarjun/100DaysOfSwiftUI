//
//  ContentView.swift
//  P02-GuessTheFlag
//
//  Created by Arjun B on 28/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showResetAlert = false
    @State private var showNextButton = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var tappedAnswer = -1
    
    @State private var score = 0
    @State private var total = 0

    var body: some View {
        ZStack {
            Image("topography")
                .resizable(resizingMode: .tile)
                .background(.teal)
                .opacity(0.03)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("GUESS THE FLAG OF")
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(countries[correctAnswer])
                        .bold()
                        .font(.largeTitle)
                }
                
                VStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button {
                            if showNextButton { return }
                            
                            if number == correctAnswer {
                                score += 1
                            }
                            
                            total += 1
                            tappedAnswer = number
                            showNextButton = true
                        } label: {
                            ZStack {
                                if !showNextButton {
                                    Image(countries[number])
                                        .renderingMode(.original)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(radius: 10)
                                } else {
                                    let opacity = (number == tappedAnswer) ? 1 : 0.5
                                    Image(countries[number])
                                        .renderingMode(.original)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(radius: 10)
                                        .opacity(opacity)
                                }
                                
                                if number == tappedAnswer {
                                    let isCorrect = (tappedAnswer == correctAnswer)
                                    let color: Color = isCorrect ? .green : .red
                                    let imageName = isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill"
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(color)
                                        .opacity(0.5)
                                    
                                    Image(systemName: imageName)
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .foregroundColor(.white)
                                        .background(color)
                                        .clipShape(Circle())
                                }
                            }
                            .fixedSize()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.teal.opacity(0.10))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("CORRECT")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        if total != 0 {
                            Text("\(score)")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.green)
                        } else {
                            Text("——")
                                .bold()
                                .opacity(0.5)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(minHeight: 60)
                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                        Text("WRONG")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        if total != 0 {
                            Text(total - score, format: .number)
                                .bold()
                                .font(.title2)
                                .foregroundColor(.red)
                        } else {
                            Text("——")
                                .bold()
                                .opacity(0.5)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(minHeight: 60)
                    
                    Spacer()
                }
                
                HStack {
                    // reset game
                    Button() {
                        showResetAlert = true
                    } label: {
                        Image(systemName: "repeat")
                            .font(.body.bold())
                            .padding(10)
                    }
                    .tint(.teal)
                    .buttonStyle(.bordered)
                    .disabled(total == 0)

                    // go to next question
                    Button() {
                        countries.shuffle()
                        correctAnswer = Int.random(in: 0...2)
                        tappedAnswer = -1
                        showNextButton = false
                    } label: {
                        Text("Next Question")
                            .bold()
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                    }
                    .tint(.teal)
                    .buttonStyle(.borderedProminent)
                    .disabled(!showNextButton)
                }
            }
            .padding(.horizontal, 30)
        }
        .alert("Restart Game?", isPresented: $showResetAlert) {
            Button("Yes", action: resetGame)
            Button("Cancel", role: .cancel) {}
        }
    }
    
    func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tappedAnswer = -1
        showNextButton = false
        score = 0
        total = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
