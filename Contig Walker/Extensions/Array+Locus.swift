//
//  Array+Locus.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import PresentationZen
import Foundation


extension Array where Element == Locus {
    
    var range: (Int, Int) {
        let locations = self.compactMap( { $0.location } )
        if let mn = locations.min(),
           let mx = locations.max() {
            return ( mn, mx )
        } else {
            return ( 0, 0 )
        }
    }

    
    var locationDataPoints: [DataPoint] {
        var ret = [DataPoint]()
        for item in self {
            ret.append( DataPoint(x: 0.0, y: Double(item.location), label: item.id ) )
        }
        return ret
    }
    
}
