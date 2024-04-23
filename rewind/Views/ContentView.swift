//
//  ContentView.swift
//  rewind
//
//  Created by Nandini Swami on 4/21/24.
//

import Foundation
import SwiftUI

struct ContentView : View {
    @EnvironmentObject var rewindViewModel: RewindViewModel
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AddView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

//// Dummy Views for demonstration
//struct HomeTestView: View {
//    var body: some View {
//        Text("Home View")
//    }
//}
//
//struct AddTestView: View {
//    var body: some View {
//        Text("Add View")
//    }
//}
//
//struct MapTestView: View {
//    var body: some View {
//        Text("Map View")
//    }
//}

#Preview {
    ContentView()
}
