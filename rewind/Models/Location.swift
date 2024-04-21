//
//  Location.swift
//  rewind
//
//  Created by George Xue on 4/21/24.
//

import Foundation

struct Location: Hashable, Identifiable, Codable {
    var id: String { "\(lat),\(lon)" }
    let lat: Double
    let lon: Double
    let name: String
    let display_name: String

    enum CodingKeys: String, CodingKey {
        case lat, lon, name, display_name
    }

    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let latDouble = try? container.decode(Double.self, forKey: .lat), let lonDouble = try? container.decode(Double.self, forKey: .lon) {
                // If lat and lon are already doubles, use them directly
                self.lat = latDouble
                self.lon = lonDouble
            } else {
                // If lat and lon are strings, attempt to convert them to doubles
                let latString = try container.decode(String.self, forKey: .lat)
                let lonString = try container.decode(String.self, forKey: .lon)
                guard let lat = Double(latString), let lon = Double(lonString) else {
                    throw DecodingError.dataCorruptedError(forKey: .lat, in: container, debugDescription: "Latitude and longitude values are not valid numbers.")
                }
                
                self.lat = lat
                self.lon = lon
            }
            
            self.name = try container.decode(String.self, forKey: .name)
            self.display_name = try container.decode(String.self, forKey: .display_name)
        }
}


struct Address: Codable {
    let city: String?
    let county: String?
    let state: String?
    let country: String?
    let country_code: String?
}
