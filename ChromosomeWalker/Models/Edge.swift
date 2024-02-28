//
//  Edge.swift
//  ChromosomeWalker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation

struct Edge: Codable {
    
    let source: Int
    let target: Int
    let weight: Double
    
    enum CodingKeys: String, CodingKey {
        case source
        case target
        case weight
    }
    

    init(weight: Double, source: Int, target: Int) {
        self.weight = weight
        self.source = source
        self.target = target
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decode(Int.self, forKey: .source)
        self.target = try container.decode(Int.self, forKey: .target)
        self.weight = try container.decode(Double.self, forKey: .weight)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode( weight, forKey: .weight )
        try container.encode( source, forKey: .source )
        try container.encode( target, forKey: .target)
    }
    
}
