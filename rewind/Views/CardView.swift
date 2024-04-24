//
//  CardView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct CardView: View {
    var card: Card
    let backgroundColor = Color(red: 242/255, green: 232/255, blue: 207/255)
    let darkGreenColor = Color(red: 56/255, green: 102/255, blue: 65/255)
    let lightGreenColor = Color(red: 106/255, green: 153/255, blue: 78/255)
    let yellowGreenColor = Color(red: 167/255, green: 201/255, blue: 87/255)
    let redColor = Color(red: 188/255, green: 71/255, blue: 73/255)
    @EnvironmentObject var rewindViewModel: RewindViewModel

    func formattedDate(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: time)
    }
    
    var body: some View {
        VStack {
            Text("Recall \(card.name)!")
                .font(.largeTitle)
                .padding(.top, 20)
            
            let time = formattedDate(time: card.date)
            Text("From: \(time)")
            
            Text(card.description)
        }
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

             
