//
//  AddView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var rewindViewModel: RewindViewModel
    @State private var placeName = ""
    @State private var location = ""
    @State private var rating = 0
    @State private var description = ""
    @State private var cardDate = Date()
    
    // Define color constants
        let backgroundColor = Color(red: 242/255, green: 232/255, blue: 207/255)
        let darkGreenColor = Color(red: 56/255, green: 102/255, blue: 65/255)
        let lightGreenColor = Color(red: 106/255, green: 153/255, blue: 78/255)
        let yellowGreenColor = Color(red: 167/255, green: 201/255, blue: 87/255)
        let redColor = Color(red: 188/255, green: 71/255, blue: 73/255)

    var body: some View {
        ScrollView{
            
            VStack {
                HStack {
                     // Pushes the content towards center
                    Text("Add a new experience to your Rewind!")
                        .font(.title)
                        .bold()
                        .foregroundColor(darkGreenColor)
                        .padding(.vertical, 4)
                    Spacer() // Pushes the content towards center
                }
                
                HStack {
                    Text("Where did you go?")
                        .font(.headline)
                        .foregroundColor(lightGreenColor)
                        .padding(.vertical, 4)
                    Spacer()
                }
                
                TextField("Enter the name of the place", text: $placeName)
                    .padding()
                    .background(backgroundColor)
                    .foregroundColor(darkGreenColor)
                
                
                HStack(spacing: 10) {
                    TextField("Enter location", text: $location)
                        .padding()
                        .background(backgroundColor)
                        .foregroundColor(darkGreenColor)
                        .frame(maxWidth: .infinity) // This ensures the TextField uses the available space

                    Button(action: {
                        Task {
                            await rewindViewModel.updateCurrLoc(currLocString: location)
                        }
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(redColor)
                            .font(.title)
                    }
                }
                
//                HStack{
//                    Text("Location not fetched yet")
//                        .font(.caption)
//                        .foregroundColor(yellowGreenColor)
//                        .padding(.leading, 20)
//                    Spacer()
//                }
                
                HStack {
                    Text("How would you rate it out of 5?")
                        .font(.headline)
                        .foregroundColor(lightGreenColor)
                        .padding(.vertical, 4)
                    Spacer()
                }
                .padding(.top, 20)
                
                Stepper(value: $rating, in: 0...5) {
                    RatingView(rating: $rating)
                }
                
                
                Text("Describe your experience:")
                    .font(.headline)
                    .foregroundColor(darkGreenColor)
                    .padding(.vertical, 4)
                
                TextEditor(text: $description)
                    .frame(height: 200)
                    .padding()
                    .background(backgroundColor)
                    .foregroundColor(darkGreenColor)
                
                
                HStack {
                    Spacer()  // This pushes everything after it to the right
                    Button("Finish") {
                        cardDate = Date()  // Set the date to the current moment right before saving
                        let locationObj = rewindViewModel.loc  // Optional, handle nil case as necessary
                        rewindViewModel.addCard(name: placeName, date: cardDate, description: description, rating: rating, location: locationObj)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    }
                    .padding()  // Adds padding around the button to ensure it's not right against the screen edge
                }
            }
        //.ignoresSafeArea()
        .padding()
        .background(backgroundColor.opacity(0.5))
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

//
//#Preview {
//    AddView()
//}
