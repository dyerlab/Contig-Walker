//
//  Locus.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-01.
//

import SwiftData
import Foundation


@Model
class Locus {
    let name: String
    let Location: UInt
    let Distance: UInt
    let Ho: Double
    let He: Double
    let p: Double
    let F: Double
    
    init(name: String, Location: UInt, Distance: UInt, Ho: Double, He: Double, p: Double, F: Double) {
        self.name = name
        self.Location = Location
        self.Distance = Distance
        self.Ho = Ho
        self.He = He
        self.p = p
        self.F = F
    }
}
