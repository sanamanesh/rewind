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
    
    let backgroundColor = Color(red: 242/255, green: 232/255, blue: 207/255)
    let darkGreenColor = Color(red: 56/255, green: 102/255, blue: 65/255)
    let lightGreenColor = Color(red: 106/255, green: 153/255, blue: 78/255)
    let yellowGreenColor = Color(red: 167/255, green: 201/255, blue: 87/255)
    let redColor = Color(red: 188/255, green: 71/255, blue: 73/255)
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            // we'll need user locaiton (permissions)
            UserAnnotation() // displays current location of user on the map
            
            // for each card in our cards array, place a marker on the map
            ForEach(rewindViewModel.cards) { card in
                Annotation(card.name, coordinate: CLLocationCoordinate2D(latitude: card.location?.lat ?? 39.952583, longitude: card.location?.lng ?? -75.165222)) {
                    Image(systemName: "mappin.circle.fill") // Use a pin image from SF Symbols
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18) // Adjust the size as needed
                                    .foregroundColor(redColor) // Use your app's theme color here

                                
                        .onTapGesture {
                            selectedCard = card
                            showDetails = true
                        }
                }
            }
                        
        }
        .sheet(item: $selectedCard, content: {
                card in
                PopupView(card: card)
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

//#Preview {
//    MapView()
//}
