//
//  ContentView.swift
//  rewind
//
//  Created by Nandini Swami on 4/21/24.
//

import Foundation
import SwiftUI

struct ContentView : View {
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

#Preview {
    ContentView()
}
