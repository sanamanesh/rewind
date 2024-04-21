//
//  CardView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @EnvironmentObject var rewindViewModel: RewindViewModel

    func formattedDate(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy, HH:mm"
        return formatter.string(from: time)
    }
    
    var body: some View {
        VStack {
            Text("Recall \(card.name)!")
                .font(.largeTitle)
                .padding(.top, 20)
            
            var time = formattedDate(time: card.date)
            Text("From: \(time)")
            
            Text(card.description)
        }
    }
  
}

//#Preview {
//    @StateObject var rewindViewModel: RewindViewModel
//    
//    CardView()
//        .environmentObject(rewindViewModel)
//}

             
