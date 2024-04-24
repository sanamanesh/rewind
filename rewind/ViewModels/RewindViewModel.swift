//
//  RewindViewModel.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation
import Combine
import CoreLocation

class RewindViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var cards: [Card] = []
    @Published var loc: Coord?
    @Published var locs: [Coord] = []
    @Published var locString: String = ""
    
    init() {
        loadCards()
    }
    
    
    // location variables
    private var locationManager = CLLocationManager()
    private var isRequestingLocation = false
    @Published var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            requestLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // function that requests the user location
    func requestLocation() {
        if !isRequestingLocation {
            isRequestingLocation = true
            locationManager.requestLocation()
            print("test request location 1")
        }
    print("test location 2")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            isRequestingLocation = false
            return
        }
            
        self.currentLocation = location
        isRequestingLocation = false
    }
    
    // manages the location of the user
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isRequestingLocation = false
        print("Failed to get location: \(error)")
    }
    
    
//    init(){
//        let testCard = Card(name: "Huntsman", date: Date(), description: "Wharton School", rating: 5)
//        cards.append(testCard)
//    }
    
    
    
    //update to deal with an address of a place
    func updateCurrLocsArray(currLocString: String) async {
        print("updating currLoc")
        
        locString = currLocString
        
        let apiCalls = APICalls() // Create an instance of APICalls
            
        do {
            try await apiCalls.getPlaceCoordinates(storeName: currLocString) { result in
                switch result {
                case .success(let coord):
                    self.locs = coord
                    print(self.locs.count)
//                    print("Latitude: \(coord.lat), Longitude: \(coord.lng)")
//                    print("Address: \(coord.addr)")
                case .failure(let error):
                    print("Error:", error)
                }
            }
        } catch {
            print("Error:", error)
        }
    }
    
    func updateCurrLocsArray(currLocCoord: Coord) {
        self.loc = currLocCoord
    }

    func addCard(name: String, description: String, rating: Int, location: Coord?) {
        let location = loc;
        print("made it to adding a card")
        let newCard = Card(name: name, location: location, description: description, rating: rating)
        DispatchQueue.main.async {
            self.cards.append(newCard)
            print(self.cards.count)
            print("date: \(self.cards[0].date), description: \(self.cards[0].description), name: \(self.cards[0].name), lat: \(String(describing: self.cards[0].location?.lat)), long: \(String(describing: self.cards[0].location?.lng))")
            self.saveCards()
        }
    }
    
    // Function to save locations array to UserDefaults
    private func saveCards() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cards)
            UserDefaults.standard.set(data, forKey: "savedCards")
        } catch {
            print("Error saving locations: \(error.localizedDescription)")
        }
    }
    
    // Function to load locations array from UserDefaults
    private func loadCards() {
        if let data = UserDefaults.standard.data(forKey: "savedCards") {
            do {
                let decoder = JSONDecoder()
                let savedCards = try decoder.decode([Card].self, from: data)
                self.cards = savedCards
            } catch {
                print("Error loading locations: \(error)")
            }
        }
    }
}
