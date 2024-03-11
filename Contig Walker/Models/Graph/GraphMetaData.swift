//
//  GraphMetaData.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/10/24.
//

import Foundation
import DLMatrix

struct GraphMetaData: Codable {
    let id: UUID
    let numNodes: Int
    let numEdges: Int
        
    /// features related to node structure
    let degree: Vector
    let closeness: Vector
    let betweenness: Vector
    
    /// features reltaed to edge structure
    let diameter: Double
    
    

}



extension GraphMetaData {
    
    /*
     
    static var DefaultMetaData: GraphMetaData {
        
        return GraphMetaData(id: 1,
                             numNodes: 29,
                             numEdges: 34,
                             startingBP: 23234,
                             endingBP: 24523,
                             
        )
    }
     */
    
}



extension GraphMetaData: Hashable, Equatable {
    
    static func ==(lhs: GraphMetaData, rhs: GraphMetaData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine( id )
    }
    
    
}
