//
//  Node.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftData
import Foundation


@Model
class Node: Codable {
    let id: String
    let size: Double
    let longitude: Double
    let latitude: Double
    let group: String
    
    enum CodingKeys: CodingKey {
        case id
        case size
        case longitude
        case latitude
        case group
    }
    
    
    init(id: String, size: Double, longitude: Double, latitude: Double, group: String) {
        self.id = id
        self.size = size
        self.longitude = longitude
        self.latitude = latitude
        self.group = group
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        id = try container.decode( String.self, forKey: .id )
        size = try container.decode( Double.self, forKey: .size )
        longitude = try container.decode( Double.self, forKey: .longitude )
        latitude = try container.decode( Double.self, forKey: .latitude )
        group = try container.decode( String.self, forKey: .group )
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode( id, forKey: .id )
        try container.encode( size, forKey: .size )
        try container.encode( longitude, forKey: .longitude )
        try container.encode( latitude, forKey: .latitude )
        try container.encode( group, forKey: .group )
    }
    
    
}

