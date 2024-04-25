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
    @State private var showPopup = false// State to control popup visibility
    @State private var showingLocationSuggestions = false // To toggle the location suggestions dropdown
    @State private var locationSaved = false //location saved
    
    
    
    // Define color constants
    let backgroundColor = Color(red: 242/255, green: 232/255, blue: 207/255)
    let darkGreenColor = Color(red: 56/255, green: 102/255, blue: 65/255)
    let lightGreenColor = Color(red: 106/255, green: 153/255, blue: 78/255)
    let yellowGreenColor = Color(red: 167/255, green: 201/255, blue: 87/255)
    let redColor = Color(red: 188/255, green: 71/255, blue: 73/255)
    
    
    
    
    var body: some View {
        ZStack{
            backgroundColor // Use your background color here
                .edgesIgnoringSafeArea(.all)
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
                    
                    Spacer()
                    
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(darkGreenColor, lineWidth: 2)
                        )
                        .cornerRadius(10)
                    
                    
                    HStack {
                        Text("Enter location:")
                            .font(.headline)
                            .foregroundColor(lightGreenColor)
                            .padding(.vertical, 4)
                        Spacer()
                        
                    }
                    HStack(spacing: 10) {
                        TextField("Enter location", text: $location)
                            .padding()
                            .background(backgroundColor)
                            .foregroundColor(darkGreenColor)
                            .frame(maxWidth: .infinity) // This ensures the TextField uses the available space
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(darkGreenColor, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            

                        Spacer()
                        
                        Button(action: {
                            Task {
                                rewindViewModel.locs = []
                                await rewindViewModel.updateCurrLocsArray(currLocString: location)
                                showingLocationSuggestions = true
                            }
                        }) {
                            if(locationSaved){
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(redColor)
                                    .font(.title)
                            } else {
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundColor(redColor)
                                    .font(.title)
                            }
                        }
                    }
                    if showingLocationSuggestions {
                        // Dropdown list for location suggestions
                        VStack {
                            ForEach(rewindViewModel.locs, id: \.self) { loc in
                                Button(action: {
                                    location = loc.addr // Set the text of the TextField to the selected location
                                    rewindViewModel.updateCurrLoc(currLocCoord: loc);                                
                                    showingLocationSuggestions = false // Hide the dropdown
                                    locationSaved = true
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Text(loc.addr)
                                        .foregroundColor(redColor)
                                        .padding()
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }
                    
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
                    .padding(.bottom, 10)
                    
                    
                    Text("Describe your experience:")
                        .font(.headline)
                        .foregroundColor(darkGreenColor)
                        .padding(.vertical, 4)
                    
                    TextEditor(text: $description)
                        .frame(height: 200)
                        .padding()
                        .background(backgroundColor)
                        .foregroundColor(darkGreenColor)
                        .cornerRadius(10)

                    
                    HStack {
                        Spacer()  // This pushes everything after it to the right
                        Button("Finish + Add") {
                            cardDate = Date()  // Set the date to the current moment right before saving
                            let locationObj = rewindViewModel.loc  // Optional, handle nil case as necessary
                            rewindViewModel.addCard(name: placeName, description: description, rating: rating, location: locationObj)
                            showPopup = true
                            showingLocationSuggestions = false
                            locationSaved = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                        }
                        .padding()
                        .background(redColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .alert(isPresented: $showPopup) {  // Alert setup
                            Alert(
                                title: Text("Card successfully added"),
                                message: Text("Your new card has been added to Rewind."),
                                dismissButton: .default(Text("Continue"), action: {
                                    // Reset fields here
                                    placeName = ""
                                    location = ""
                                    rating = 0
                                    description = ""
                                })
                            )
                        }
                    }
                    //focus modifier for keyboard
                    //https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
                        //UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .padding()
                //.background(backgroundColor.opacity(0.5))
            }
        }
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
