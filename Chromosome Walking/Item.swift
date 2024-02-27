//
//  Item.swift
//  Chromosome Walking
//
//  Created by Rodney Dyer on 2024-02-27.
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
