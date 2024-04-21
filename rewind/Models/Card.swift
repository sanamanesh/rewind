//
//  Card.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation

struct Card : Identifiable {
    var id: String { "\(name)" }
    var name: String
    var date: Date
    var location: Location?
    var description: String
    var rating: Int
}
