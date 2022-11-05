//
//  DetailView.swift
//  P11-Bookworm
//
//  Created by Arjun B on 01/11/22.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .cornerRadius(8)
                    .offset(x: -5, y: -5)
            }
            Text(book.title ?? "Unknown Book")
                .font(.largeTitle)
            
            Text(book.author ?? "Unknown Author")
                .font(.headline)
                .foregroundColor(.secondary)
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.title)
                .padding(.vertical)
            
            Text(book.review ?? "No Review")
                .padding()
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}

// working with previews when using CoreData is a hassle
