//
//  HomeView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct HomeView: View {
    init(){
        print("HomeView initialized")
    }
    @EnvironmentObject var rewindViewModel: RewindViewModel
    @State private var showingSheet = false
    
    var body: some View {
        
        Text("Inside Home View!")
        
        let testCard = Card(name: "Huntsman", description: "Wharton School", rating: 5)
        
        Button("Test Card") {
            showingSheet = true // Toggle the boolean to show the sheet
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
        .sheet(isPresented: $showingSheet) { // Use the boolean state directly
            CardView(card: testCard) // Pass the instance of Card directly
        }
        
    }
}

#Preview {
    HomeView()
}
