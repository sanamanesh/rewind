//
//  HomeView.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var rewindViewModel: RewindViewModel
    @State private var showingSheet = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        // Add more GridItems if you want more columns
    ]
    
    var body: some View {
        NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(rewindViewModel.cards) { card in
                                CardView(card: card)
                                    .onTapGesture {
                                        // Here you can define what happens when a card is tapped.
                                        // For example, you can set showingSheet to true and show details in a sheet.
                                    }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("REWIND IN PHILLY")
                }
    }
}

#Preview {
    HomeView()
}
