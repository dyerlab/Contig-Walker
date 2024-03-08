//
//  Edge.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftData
import Foundation

class Edge: Codable {
    let source: String
    let target: String
    let weight: Double
    
    enum CodingKeys: CodingKey {
        case source
        case target
        case weight
    }
    
    init(source: String, target: String, weight: Double) {
        self.source = source
        self.target = target
        self.weight = weight
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        source = try container.decode( String.self, forKey: .source )
        target = try container.decode( String.self, forKey: .target )
        weight = try container.decode( Double.self, forKey: .weight )
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode( source, forKey: .source )
        try container.encode( target, forKey: .target )
        try container.encode( weight, forKey: .weight )
    }
}


extension Edge: CustomStringConvertible {
    
    var description: String {
        return "\(source) <-- \(weight) --> \(target)"
    }
}


