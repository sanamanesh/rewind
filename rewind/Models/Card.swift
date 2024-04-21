//
//  Card.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation

struct Card : Identifiable {
    var id: String { "\(name)" }
    let name: String
    let date: Date
    let location: Location
    let description: String
    let rating: Int
}
