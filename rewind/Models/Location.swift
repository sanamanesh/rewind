//
//  Location.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation

struct Coord: Codable, Hashable {
    var id: String { "\(lat),\(lng)" }
    let addr: String
    let lat: Double
    let lng: Double
}
