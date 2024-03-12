//
//  Locus.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Foundation

class Locus: Identifiable, Codable  {
    let id: String
    let coordinate: Int
    let p: Double
    let Ho: Double
    let Hs: Double
    let Ht: Double
    
    /// The other allele
    var q: Double {
        return 1.0 - p
    }
    
    /// Frequency corrected effective diversity
    var Ae: Double{
        return 1.0 / ( (p*p) + ( q*q) )
    }
    
    /// Expected heterozygosity 2pq
    var He: Double {
        return (1.0 - p) * p * 2.0
    }
    
    var Fis: Double {
        if He > 0  {
            return 1.0 - (Ho / He)
        } else {
            return Double.nan
        }
    }
    
    /// Variance in allele frequencies Fst
    var Fst: Double {
        if Ht != 0 {
            return 1.0 - Hs/Ht
        } else {
            return Double.nan
        }
    }
    
    /// Shannon-Wiener Diversity Index
    var SW: Double {
        return  ( p * log2(p)) + (q * log2(q) )
    }

    init(id: String, coordinate: Int, p: Double, Ho: Double, Hs: Double, Ht: Double) {
        self.id = id
        self.coordinate = coordinate
        self.p = p
        self.Ho = Ho
        self.Hs = Hs
        self.Ht = Ht
    }
    
}




extension Locus: Equatable, Hashable, Comparable {
    
    static func < (lhs: Locus, rhs: Locus) -> Bool {
        return lhs.coordinate < rhs.coordinate
    }
    
    static func == (lhs: Locus, rhs: Locus) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(coordinate)
    }
}



extension Locus {
    
    static var DefaultLoci: [Locus] {
        let json = GraphJSONLoader.DefaultGraph
        return json.asLoci
    }
    
}
