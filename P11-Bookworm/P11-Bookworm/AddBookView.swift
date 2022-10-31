//
//  AddBookView.swift
//  P11-Bookworm
//
//  Created by Arjun B on 31/10/22.
//

import SwiftUI

struct BookData {
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var title: String
    var author: String
    var rating: Int
    var genre: String
    var review: String
}

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var book = BookData(title: "", author: "", rating: 3, genre: "", review: "")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of Book", text: $book.title)
                    TextField("Author's Name", text: $book.author)
                    
                    Picker("Genre", selection: $book.genre) {
                        ForEach(BookData.genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Picker("Rating", selection: $book.rating) {
                        ForEach(1..<6, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    
                    TextEditor(text: $book.review)
                } header: {
                    Text("Write a Review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = book.title
                        newBook.author = book.author
                        newBook.rating = Int16(book.rating)
                        newBook.genre = book.genre
                        newBook.review = book.review
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
