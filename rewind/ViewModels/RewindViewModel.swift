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
    @Published var locString: String = ""
    
    
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
    func updateCurrLoc(currLocString: String) async {
        print("updating currLoc")
        
        locString = currLocString
        
        let apiCalls = APICalls() // Create an instance of APICalls
            
        do {
            try await apiCalls.getPlaceCoordinates(storeName: currLocString) { result in
                switch result {
                case .success(let coord):
                    self.loc = coord
                    print("Latitude: \(coord.lat), Longitude: \(coord.lng)")
                    print("Address: \(coord.addr)")
                case .failure(let error):
                    print("Error:", error)
                }
            }
        } catch {
            print("Error:", error)
        }
//        do {
//            if let location = try? await APICalls.instance.getLocation(city: locString) {
//                    self.loc = location.first
//            } else {
//                // Handle case where API call returns nil (or encounters an error)
//                print("LOCATION - Error or nil result from API call")
//            }
//        }
//        print("set the current location to \(String(describing: loc))")
    }
    
    func addCard(name: String, description: String, rating: Int, location: Coord?) {
        let location = loc;
        print("made it to adding a card")
        let newCard = Card(name: name, location: location, description: description, rating: rating)
        DispatchQueue.main.async {
            self.cards.append(newCard)
            print(self.cards.count)
            print("date: \(self.cards[0].date), description: \(self.cards[0].description), name: \(self.cards[0].name), lat: \(String(describing: self.cards[0].location?.lat)), long: \(String(describing: self.cards[0].location?.lng))")
        }
        
        
        
    }
}
