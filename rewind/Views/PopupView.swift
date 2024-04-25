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
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                
                
                VStack (alignment: .leading, spacing: 20){
                    Text("Recall...")
                        .italic()
                        .foregroundColor(lightGreenColor)
                        .font(.title)
                        .padding(.top, 40)
                    HStack {
                        Spacer()
                        Text("\(card.name) <3")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundColor(redColor)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Text("Date: \(formattedDate(time: card.date))")
                            .foregroundColor(darkGreenColor)
                            .font(.headline)
                            //.fontWeight(.headline)
                        Spacer()
                        HStack {
                            ForEach(1...5, id: \.self) { number in
                                Image(systemName: number <= card.rating ? "star.fill" : "star")
                                    .foregroundColor(number <= card.rating ? .yellow : Color.gray)
                            }
                        }
                    }
                    
                    if let location = card.location {
                        Text("@ \(location.addr)")
                            .foregroundColor(darkGreenColor)
                            .font(.subheadline)
                    }
                    
                    Text("Description:")
                        .foregroundColor(darkGreenColor)
                        .font(.headline)
                        .padding(.top, 5)
                    
                    Text(card.description)
                        .foregroundColor(lightGreenColor)
                        .font(.body)
                        .lineLimit(nil)
                    
                    Spacer()
                    
                    Button(action: {
                        // Show delete confirmation
                        rewindViewModel.removeCard(id: card.id)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete")
                        }
                        .font(.subheadline)
                        .foregroundColor(lightGreenColor)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(backgroundColor)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lightGreenColor, lineWidth: 1)
                        )
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal)
            }
        }
    }
}
