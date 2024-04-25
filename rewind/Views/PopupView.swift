//
//  PopupView.swift
//  rewind
//
//  Created by Sana Manesh on 4/24/24.
//

import Foundation
import SwiftUI

struct PopupView: View {
    var card: Card
    let backgroundColor = Color(red: 242/255, green: 232/255, blue: 207/255)
    let darkGreenColor = Color(red: 56/255, green: 102/255, blue: 65/255)
    let lightGreenColor = Color(red: 106/255, green: 153/255, blue: 78/255)
    let yellowGreenColor = Color(red: 167/255, green: 201/255, blue: 87/255)
    let redColor = Color(red: 188/255, green: 71/255, blue: 73/255)
    @EnvironmentObject var rewindViewModel: RewindViewModel
    @Environment(\.presentationMode) var presentationMode

    
    func formattedDate(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: time)
    }
    
    var body: some View {
        ScrollView {
//            backgroundColor.opacity(0.5) // Use your background color here
//                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack{
                    Spacer(minLength: 40)

                    HStack {
                        Text("recall")
                            .italic()
                            .foregroundColor(lightGreenColor)
                            .font(.largeTitle)
                            .padding(.leading, 15)
                        Spacer()
                    }
                    
                    Text(card.name)
                        .foregroundColor(darkGreenColor)
                        .bold()
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                    
                    
                    Text("Address: \(card.location!.addr)")
                        .foregroundColor(lightGreenColor)
                        .padding(.bottom, 20)
                    
                    let time = formattedDate(time: card.date)
                    
                    HStack {
                        Text("From: \(time)")
                            .foregroundColor(lightGreenColor)
                            .padding(.leading, 15)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    
                    HStack{
                        HStack {
                            ForEach(1...5, id: \.self) { number in
                                Image(systemName: number <= card.rating ? "star.fill" : "star")
                                    .foregroundColor(number <= card.rating ? Color.yellow : Color.gray)
                            }
                        }
                        .padding(.leading, 15)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    HStack{
                        Text("Description: \(card.description)")
                            .lineLimit(nil) // or .lineLimit(0) for SwiftUI versions that support it
                            .padding(.leading, 15)
                        Spacer()
                    }
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        // Show delete confirmation
                        rewindViewModel.removeCard(id: card.id)
                        
                        presentationMode.wrappedValue.dismiss()

                    }) {
                        Text("Delete")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            
           
        }
        .background(backgroundColor.opacity(0.5))
    }
}
    
    //#Preview {
    //    @EnvironmentObject var rewindViewModel: RewindViewModel
    //    let testCard = Card(name: "Huntsman", date: Date(), description: "Wharton School", rating: 5)
    //
    //
    //    CardView(card: Card = testCard)
    //        .environmentObject(rewindViewModel)
    //}
    

