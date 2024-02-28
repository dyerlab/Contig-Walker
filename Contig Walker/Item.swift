//
//  Item.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2/28/24.
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
