//
//  MapView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        Map(position: $cameraPosition) {
            
            // we'll need user locaiton (permissions)
            UserAnnotation() // displays current location of user on the map
            
            // fake location
            Annotation("My Fake Location", coordinate: .userLocation) {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.blue.opacity(0.25))
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.blue)
                }
            }
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
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
