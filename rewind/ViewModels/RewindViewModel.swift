//
//  RewindViewModel.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation

class RewindViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var loc: Location?
    @Published var locString: String = ""
    
//    init(){
//        let testCard = Card(name: "Huntsman", date: Date(), description: "Wharton School", rating: 5)
//        cards.append(testCard)
//    }
    
    //update to deal with an address of a place
    func updateCurrLoc(currLocString: String) async {
        print("updating currLoc")
        
        locString = currLocString
        do {
            if let location = try? await APICalls.instance.getLocation(city: locString) {
                    self.loc = location.first
            } else {
                // Handle case where API call returns nil (or encounters an error)
                print("LOCATION - Error or nil result from API call")
            }
        }
        print("set the current location to \(String(describing: loc))")
    }
    
    func addCard(name: String, description: String, rating: Int, location: Location?) {
        print("made it to adding a card")
        let newCard = Card(name: name, location: location, description: description, rating: rating)
        DispatchQueue.main.async {
            self.cards.append(newCard)
        }
        
    }
}
