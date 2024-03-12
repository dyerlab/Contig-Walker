//
//  Array+GraphMetaData.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-12.
//

import Foundation
import PresentationZen

extension Array where Element == GraphMetaData {
    
    var dataPoints: [DataPoint] {
        var ret = [DataPoint]()
        
        for item in self {
            ret.append(contentsOf:  item.dataPoints )
        }
        
        return ret
    }
    
    
    
}
