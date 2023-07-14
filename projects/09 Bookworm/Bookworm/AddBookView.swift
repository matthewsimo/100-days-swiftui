//
//  AddBookView.swift
//  Bookworm
//
//  Created by Matthew Simo on 7/14/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    
                } header: {
                    Text("Write a review")
                        .font(.headline)
                }
                
                Section {
                    Button("Save") {
                        // Add here
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(isDisabled)
                }
                
            }
            .navigationTitle("Add book")
        }
    }
    
    var isDisabled: Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        
        if rating < 0 || rating >= genres.count {
            return true
        }
        
        return false
    }
}

#Preview {
    AddBookView()
}
