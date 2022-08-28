//
//  ContentView.swift
//  P02-GuessTheFlag
//
//  Created by Arjun B on 28/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var total = 0
    
    var body: some View {
        ZStack {
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
                            if number == correctAnswer {
                                scoreTitle = "Correct"
                                score += 1
                            } else {
                                scoreTitle = "Wrong"
                            }
                            
                            total += 1
                            showingScore = true
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.thinMaterial)
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
            }
            .padding(.horizontal, 30)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
