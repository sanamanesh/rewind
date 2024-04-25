//
//  MapView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var rewindViewModel: RewindViewModel
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var mapSelection: MKMapItem?
    @State private var selectedCard: Card?
    @State private var showDetails = false
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
            
            // we'll need user locaiton (permissions)
            UserAnnotation() // displays current location of user on the map
            
            // for each card in our cards array, place a marker on the map
            ForEach(rewindViewModel.cards, id: \.self) { card in
                if let mapItem = rewindViewModel.convertCardToMKMapItem(card: card) {
                    Marker(mapItem.name ?? "", coordinate: mapItem.placemark.coordinate)
                }
            }
            
            ForEach(rewindViewModel.cards, id: \.self) { card in
              if let mapItem = rewindViewModel.convertCardToMKMapItem(card: card) {
                Marker(item: mapItem) // Use Marker(item:)
              } else {
                // Handle case where card doesn't have a valid location
                print("Card \(card.name) has missing location data")
              }
            }
                        
        }
        .onChange(of: mapSelection, { oldValue, newValue in
            if let newValue = newValue {
                // Find the card that matches the tapped location
                selectedCard = rewindViewModel.cards.first { card in
                    guard let cardLocation = card.location else { return false }
                    let cardCoordinate = CLLocationCoordinate2D(latitude: cardLocation.lat, longitude: cardLocation.lng)
                    return cardCoordinate.isEqual(to: newValue.placemark.coordinate)
                }
            } else {
                selectedCard = nil
            }
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            MapCardView(mapSelection: $mapSelection, show: $showDetails, card: selectedCard!)
        })
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
            MapScaleView()
        }
    }
}

// example of user location
// eventual will use user permision to get the location of the user (homework 3 - dining hall)
extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 39.952583, longitude: -75.165222)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                    latitudinalMeters: 10000,
                    longitudinalMeters: 10000)
    }
}

// helper function to compare two 'CLLocationCoordinate2D' objects
extension CLLocationCoordinate2D {
    func isEqual(to coordinate: CLLocationCoordinate2D) -> Bool {
        let threshold = 0.000001 // This can be adjusted to the precision you need
        return (abs(self.latitude - coordinate.latitude) < threshold) &&
               (abs(self.longitude - coordinate.longitude) < threshold)
    }
}


//#Preview {
//    MapView()
//}
