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
                        
                    }
                    Text(formattedDate(time: card.date))
                        .font(.subheadline)
                    
                    Text("Recap: \(card.description)")
                        .font(.caption)
                        .lineLimit(3)
                        .padding(.bottom, 5)
                    HStack {
                            ForEach(0..<5, id: \.self) { index in
                                    Image(systemName: index < card.rating ? "star.fill" : "star")
                                        .foregroundColor(index < card.rating ? .yellow : .gray)
                                }
                        }
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

             
