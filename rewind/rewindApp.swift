//
//  rewindApp.swift
//  rewind
//
//  Created by Sana Manesh on 4/21/24.
//

import SwiftUI

@main
struct rewindApp: App {
    @StateObject var rewindViewModel = RewindViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(rewindViewModel)
        }
    }
}
