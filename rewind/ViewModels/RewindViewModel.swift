//
//  RewindViewModel.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation

class RewindViewModel: ObservableObject {
    @Published var cards: [Card] = []
    
    init(){
        let testCard = Card(name: "Huntsman", date: Date(), description: "Wharton School", rating: 5)
        cards.append(testCard)
    }

}
