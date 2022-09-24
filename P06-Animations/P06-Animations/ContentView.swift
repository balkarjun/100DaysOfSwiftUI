//
//  ContentView.swift
//  P06-Animations
//
//  Created by Arjun B on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var isShowing = false
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    isShowing.toggle()
                }
            } label: {
                Text(isShowing ? "Hide Card" : "View Card")
                    .font(.monospaced(.body)())
                    .bold()
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.bordered)
            .tint(.orange)
            
            if isShowing {
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                withAnimation {
                                    dragAmount = .zero
                                }
                            }
                    )
                    .transition(.scale)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
