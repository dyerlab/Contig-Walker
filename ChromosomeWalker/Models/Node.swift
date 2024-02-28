//
//  Node.swift
//  ChromosomeWalker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation

struct Node: Identifiable, Codable {
    let id: String
    let size: CGFloat
    
    enum CodingKeys: String, CodingKey {
        case id
        case size
    }
    
    
    init(name: String, size: CGFloat ) {
        self.id = name
        self.size = size
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.size = try container.decode(CGFloat.self, forKey: .size)
    }
    

    func encode(to encoder: Encoder) throws {
        var container = encoder.container( keyedBy: CodingKeys.self )
        try container.encode( id, forKey: .id )
        try container.encode( size, forKey: .size )
    }
    
    
}



