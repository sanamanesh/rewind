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
    @State private var showDetails = false
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
            
            // we'll need user locaiton (permissions)
            UserAnnotation() // displays current location of user on the map
            
            // for each card in our cards array, place a marker on the map
            ForEach(rewindViewModel.cards) { card in
                Marker(card.name, coordinate: CLLocationCoordinate2D(latitude: card.location?.lat ?? 39.952583, longitude: card.location?.lng ?? -75.165222))
            }
                        
        }
        .onChange(of: mapSelection, { oldValue, newValue in
            
        })
        .sheet(isPresented: $showDetails, content: {
            CardView(mapSelection: , show: )
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

#Preview {
    MapView()
}
