//
//  Locus.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Foundation

class Locus: Identifiable, Codable  {
    let id: String
    let location: Int
    let p: Double
    let Ho: Double
    let He: Double
    
    init(name: String, location: Int, p: Double, Ho: Double, He: Double) {
        self.id = name
        self.location = location
        self.p = p
        self.Ho = Ho
        self.He = He
    }
    
}




extension Locus: Equatable, Hashable, Comparable {
    
    static func < (lhs: Locus, rhs: Locus) -> Bool {
        return lhs.location < rhs.location
    }
    
    static func == (lhs: Locus, rhs: Locus) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(location)
    }
}
