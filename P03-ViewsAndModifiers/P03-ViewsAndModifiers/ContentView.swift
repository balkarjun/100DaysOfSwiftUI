//
//  ContentView.swift
//  P03-ViewsAndModifiers
//
//  Created by Arjun B on 31/08/22.
//

import SwiftUI

// custom modifier
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .bold()
                .foregroundColor(.primary)
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .background(.thinMaterial)
                .cornerRadius(6)
                .padding(8)
        }
    }
}

// extension, so we can use .watermark()
// instead of .modifier(Watermark())
extension View {
    func watermark(text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ColoredCard: View {
    var color: Color
    
    var body: some View {
        color
            .cornerRadius(8)
            .frame(width: 300, height: 200)
            .watermark(text: "@balkarjun")
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            ColoredCard(color: .yellow)
            
            ColoredCard(color: .orange)
            
            ColoredCard(color: .red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
