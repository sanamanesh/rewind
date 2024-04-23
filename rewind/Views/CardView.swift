//
//  CardView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct CardView: View {
    var card: Card
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

             
