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
                    backgroundColor // Use your background color here
                        .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack{
                            Spacer()
                            Text("Rewind in")
                                .font(.system(size: 28, weight: .bold, design: .default))
                            //.font(.title)
                            //.fontWeight(.bold)
                                .foregroundColor(lightGreenColor)
                                .padding(.top, 60) // Adjust this value to move your title down if necessary
                                .padding(.horizontal)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("Philadelphia <3")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(darkGreenColor)
                                .padding(.top, 0) // Adjust this value to move your title down if necessary
                                .padding(.horizontal)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                    LazyVGrid(columns: columns, spacing: 1) {
                        ForEach(rewindViewModel.cards) { card in
                            CardView(card: card)
                                .shadow(radius: 5) // Subtle shadow for depth
                                .onTapGesture {
                                    currCard = card
                            }
                        }
                        
                    }
                    .sheet(item: $currCard, content: {
                        card in PopupView(card: card) })
                    .padding()
                }
                //.navigationTitle("rewind")
            }
                .background(backgroundColor) // Apply background color
        }
    }
        
}

//#Preview {
//    HomeView()
//}
