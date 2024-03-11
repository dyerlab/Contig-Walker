//
//  Vector.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-11.
//

import DLMatrix
import Foundation

extension Vector {
    
    var mean: Double {
        return self.sum / Double( self.count )
    }
    
}
