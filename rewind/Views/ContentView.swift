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
    let backgroundColor = Color(red: 242/255, green: 232/255, blue: 207/255)
    let darkGreenColor = Color(red: 56/255, green: 102/255, blue: 65/255)
    let lightGreenColor = Color(red: 106/255, green: 153/255, blue: 78/255)
    let yellowGreenColor = Color(red: 167/255, green: 201/255, blue: 87/255)
    let redColor = Color(red: 188/255, green: 71/255, blue: 73/255)
    
    init() {
        // Customize the colors using UIKit
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(backgroundColor)

        // To apply text and icon colors for both selected and unselected states
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(darkGreenColor)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(darkGreenColor)]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(lightGreenColor)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(lightGreenColor)]

        // Apply the appearance to the tab bar
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance // For iOS 15 and above
    }

    
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
        .accentColor(darkGreenColor)
    }
}

//
//#Preview {
//    ContentView()
//}
