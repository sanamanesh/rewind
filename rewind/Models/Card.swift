//
//  Card.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation

struct Card : Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var date = Date()
    var location: Coord?
    var description: String
    var rating: Int
}
