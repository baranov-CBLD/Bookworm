//
//  AddBookView.swift
//  Bookworm
//
//  Created by Kirill Baranov on 19/01/24.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = "Choose one"
    @State private var review = ""
    
    var isDisabled: Bool {
        title == "" || author == "" || rating == 0 || genre == "Choose one"
    }
    
    let genres = ["Choose one", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
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
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        addBook()
                        dismiss()
                    }
                    .disabled(isDisabled)
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func addBook() {
        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
        modelContext.insert(newBook)
    }
}

#Preview {
    AddBookView()
}
