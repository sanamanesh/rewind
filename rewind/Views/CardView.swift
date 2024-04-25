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
        VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "pin.fill") // Placeholder for location pin icon
                            .foregroundColor(redColor)
                        Text(card.name)
                            .font(.headline)
                            .foregroundColor(darkGreenColor)
                            .lineLimit(nil)
                            .minimumScaleFactor(0.9)
                        Spacer()
                        
                    }
                    //.padding(.leading, 10)
                    .padding()
            
                    Text(formattedDate(time: card.date))
                        //.font(.subheadline)
                        .font(.subheadline)
                        .foregroundColor(lightGreenColor)
                        .padding(.leading, 10)
                    
                    Text("Recap: \(card.description)")
                        .font(.caption)
                        .lineLimit(3)
                        .foregroundColor(yellowGreenColor)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 1)
                    HStack {
//                            ForEach(0..<5, id: \.self) { index in
//                                    Image(systemName: index < card.rating ? "star.fill" : "star")
//                                        .foregroundColor(index < card.rating ? .yellow : .gray)
//                                }
                        ForEach(0..<card.rating, id: \.self) { index in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                ForEach(card.rating..<5, id: \.self) { index in
                                    Image(systemName: "star")
                                        .foregroundColor(.gray)
                                }
                        
                        }
                    .padding()
                    .padding(.top,0)
                }
        //.padding([.top, .horizontal])
        .background(Color.white) // Background should be set before cornerRadius
        .cornerRadius(20) // Now this will clip the background
        .shadow(radius: 3) // Shadow should be applied after cornerRadius
        .frame(width: 170, height: 250)
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

             
