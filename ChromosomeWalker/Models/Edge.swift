//
//  Edge.swift
//  ChromosomeWalker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation

struct Edge: Identifiable, Codable {
    let id: UUID
    let weight: Double
    let fromNode: UUID
    let toNode: UUID
    
    enum CodingKeys: String, CodingKey {
        case id
        case weight
        case fromNode
        case toNode
    }
    

    init(weight: Double, from: UUID, to: UUID) {
        self.id = UUID()
        self.weight = weight
        self.fromNode = from
        self.toNode = to
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.weight = try container.decode(Double.self, forKey: .weight)
        self.fromNode = try container.decode(UUID.self, forKey: .fromNode)
        self.toNode = try container.decode(UUID.self, forKey: .toNode)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode( id, forKey: .id )
        try container.encode( weight, forKey: .weight )
        try container.encode( fromNode, forKey: .fromNode )
        try container.encode( toNode, forKey: .toNode)
    }
    
}
