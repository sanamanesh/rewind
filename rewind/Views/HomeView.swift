//
//  HomeView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var rewindViewModel: RewindViewModel
    @State var currCard: Card?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        // Add more GridItems if you want more columns
    ]
    
    // Define color constants
    let backgroundColor = Color(red: 242/255, green: 232/255, blue: 207/255)
    let darkGreenColor = Color(red: 56/255, green: 102/255, blue: 65/255)
    let lightGreenColor = Color(red: 106/255, green: 153/255, blue: 78/255)
    let yellowGreenColor = Color(red: 167/255, green: 201/255, blue: 87/255)
    let redColor = Color(red: 188/255, green: 71/255, blue: 73/255)
    
    var body: some View {
            NavigationView {
                ZStack {
                    backgroundColor.opacity(0.5) // Use your background color here
                        .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(rewindViewModel.cards) { card in
                            CardView(card: card)
                            //                                    .onTapGesture {
                            //                                        // Here you can define what happens when a card is tapped.
                            //                                        // For example, you can set showingSheet to true and show details in a sheet.
                            //                                    }
                                .cornerRadius(10) // Rounded corners for card
                                .shadow(radius: 5) // Subtle shadow for depth
                                .onTapGesture {
                                    currCard = card
                                }
                                
                        }
                        
                    }
                    .sheet(item: $currCard, content: {
                        card in
                        // Detail view or expanded card view could go here
                        PopupView(card: card)
//                                    Text("Details for \(card.name)")
//                                        .foregroundColor(darkGreenColor) // Applying the color theme
                    })
                    .padding()
                }
                .navigationTitle("rewind")
            }
            .background(backgroundColor) // Apply background color
        }
    }
        
}

//#Preview {
//    HomeView()
//}
