//
//  Edge.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftData
import Foundation

@Model
class Edge {
    let source: Node
    let target: Node
    let weight: Double
    
    init(source: Node, target: Node, weight: Double) {
        self.source = source
        self.target = target
        self.weight = weight
    }
}

