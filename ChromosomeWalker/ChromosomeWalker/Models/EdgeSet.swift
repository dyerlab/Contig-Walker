//
//  EdgeSet.swift
//  ChromosomeWalker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation

class EdgeSet: Identifiable, Codable {
    
    var location: String = ""
    var loci: String = ""
    var startLocation: Int = 0
    var endLocation: Int = 1
    var edges: [Edge] = []
    
    init(location: String) {
        self.location = location
    }
}
