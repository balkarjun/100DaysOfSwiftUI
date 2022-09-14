//
//  ContentView.swift
//  P05-WordScramble
//
//  Created by Arjun B on 13/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var totalScore: Int {
        usedWords.reduce(0) { $0 + $1.count }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Button("skip", action: skipWord)
                    .font(.monospaced(.body.bold())())
                    .buttonStyle(.bordered)
                    .tint(.teal)
                
                HStack(spacing: 5) {
                    ForEach(rootWord.map { String($0) }, id: \.self) { letter in
                        Text(letter.uppercased())
                            .font(.monospaced(.largeTitle.bold())())
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 48)
            
            TextField("Type your word", text: $newWord)
                .font(.monospaced(.body)())
                .autocapitalization(.none)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(8)
                .padding()
            
            HStack {
                Text("Total Score")
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(totalScore, format: .number)
                    .foregroundColor(.blue)
            }
            .font(.monospaced(.body.bold())())
            .padding(.horizontal, 30)
            .padding(.bottom)
            
            List(usedWords, id: \.self) { word in
                HStack {
                    Text(word)
                        .font(.monospaced(.body)())
                    
                    Spacer()
                    
                    Text(word.count, format: .number)
                        .font(.monospaced(.body.bold())())
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
            }
            .listStyle(.inset)
        }
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    func skipWord() {
        startGame()
        usedWords.removeAll()
        newWord = ""
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard isAnswerValid(word: answer) else { return }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        // if we reach here, loading the resource failed
        fatalError("Could not load start.txt from bundle")
    }
    
    func isAnswerValid(word: String) -> Bool {
        // has at least 3 letters
        if word.count < 3 {
            wordError(title: "Word too short", message: "Must be at least 3 letters long")
            return false
        }
        // is not same as start word
        if word == rootWord {
            wordError(title: "Same as root word", message: "Can't use question word as an answer")
            return false
        }
        // is original
        if usedWords.contains(word) {
            wordError(title: "Word already used", message: "Try thinking of a new one")
            return false
        }
        // is possible from root word
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                wordError(title: "Word not possible", message: "Can't spell that from \(rootWord)")
                return false
            }
        }
        // is a valid word
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if misspelledRange.location != NSNotFound {
            wordError(title: "Not a real word", message: "I don't recognize this word")
            return false
        }
        
        return true
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
