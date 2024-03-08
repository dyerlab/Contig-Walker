//
//  Locus.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import SwiftData
import Foundation


@Model
class Locus {
    let name: String
    let location: Int
    let p: Double
    let Ho: Double
    let He: Double
    
    init(name: String, location: Int, p: Double, Ho: Double, He: Double) {
        self.name = name
        self.location = location
        self.p = p
        self.Ho = Ho
        self.He = He
    }
    
}

