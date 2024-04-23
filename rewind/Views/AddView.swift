//
//  AddView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct AddView: View {
    @State private var placeName = ""
    @State private var location = ""
    @State private var rating = 0
    @State private var description = ""
    var body: some View {
        VStack {
            TextField("Name of the Place", text: $placeName)
                .padding()
            TextField("Location", text: $location)
                .padding()
            Stepper(value: $rating, in: 0...5) {
                RatingView(rating: $rating)
            }
            .padding()
            TextEditor(text: $description)
                .frame(height: 200)
                .padding()

            Spacer()

            Button(action: {
                // Add button action
                // Here you can implement the logic to add the data to your model or database
                // For example, you can create a Place object with the entered data and save it
            }) {
                Text("Add")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

/// Custom View for displaying stars based on the rating and showing the number of stars
struct RatingView: View {
    @Binding var rating: Int

    private func starType(index: Int) -> String {
        return index <= rating ? "star.fill" : "star"
    }

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: starType(index: index))
                    .foregroundColor(Color.yellow)
            }
            Text("\(rating)/5")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}

#Preview {
    AddView()
}
