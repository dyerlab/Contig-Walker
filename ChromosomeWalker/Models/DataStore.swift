//
//  DataStore.swift
//  ChromosomeWalker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation


class DataStore: Identifiable, Codable {
    let id: UUID
    var nodes: [Node] = []
    var edgeSets: [EdgeSet] = []
    
    init(nodes: [Node] = [], edgeSets: [EdgeSet] = []) {
        self.id = UUID()
        self.nodes = nodes
        self.edgeSets = edgeSets
    }
    
}
