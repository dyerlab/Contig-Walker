//
//  Node.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftData
import Foundation


@Model
class Node {
    let name: String
    let size: Double
    let group: String
    
    init(name: String, size: Double, group: String) {
        self.name = name
        self.size = size
        self.group = group
    }

}

