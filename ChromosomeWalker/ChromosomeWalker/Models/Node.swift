//
//  Node.swift
//  ChromosomeWalker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation

struct Node: Identifiable, Codable {
    
    let id: UUID
    let name: String
    let size: CGFloat
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case size
    }
    
    
    init(name: String, size: CGFloat ) {
        self.id = UUID()
        self.name = name
        self.size = size
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.size = try container.decode(CGFloat.self, forKey: .size)
    }
    

    func encode(to encoder: Encoder) throws {
        var container = encoder.container( keyedBy: CodingKeys.self )
        try container.encode( id, forKey: .id )
        try container.encode( name, forKey: .name )
        try container.encode( size, forKey: .size )
    }
    
    
}
