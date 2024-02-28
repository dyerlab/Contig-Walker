//
//  Item.swift
//  Chromosome Walker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
