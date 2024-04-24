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
        VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "pin.fill") // Placeholder for location pin icon
                            .foregroundColor(.red)
                        Text(card.name)
                            .font(.headline)
                        Spacer()
                        Text(formattedDate(time: card.date))
                            .font(.subheadline)
                    }
                    
                    Text("Recap: \(card.description)")
                        .font(.caption)
                        .lineLimit(3)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
                .frame(width: 150, height: 200) // Adjust the size as needed
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

             
