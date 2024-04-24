//
//  PopupView.swift
//  rewind
//
//  Created by Nandini Swami on 4/24/24.
//

import Foundation
import SwiftUI

struct SuccessPopupView: View {
    @Binding var isPresented: Bool
    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)

            Text("Card successfully added")
                .font(.headline)
                .foregroundColor(.primary)

            Text("Your new card has been added to Rewind.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button(action: {
                onContinue()
                isPresented = false
            }) {
                Text("Continue")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}
