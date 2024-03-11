//
//  GraphMetaData.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/10/24.
//

import PresentationZen
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
     
    static var DefaultMetaData: GraphMetaData {
        return Graph.DefaultGraph.metaData!
    }

}


extension GraphMetaData: DataPointProvider {
    
    var dataPoints: [PresentationZen.DataPoint] {
        return [  DataPoint(category: "Nodes",       value: 0.0, label: String(numNodes) ),
                  DataPoint(category: "Edges",       value: 0.0, label: String(numEdges) ),
                  DataPoint(category: "Degree",      value: 0.0, label: String(format: "%.2f", degree.mean) ),
                  DataPoint(category: "Closeness",   value: 0.0, label: String(format: "%.2f", closeness.mean) ),
                  DataPoint(category: "Betweenness", value: 0.0, label: String(format: "%.2f", betweenness.mean) ),
                  DataPoint(category: "Diameter",    value: 0.0, label: String(format: "%.2f", diameter) ) ]
    }
    
}



extension GraphMetaData: Hashable, Equatable {
    
    static func ==(lhs: GraphMetaData, rhs: GraphMetaData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine( id )
    }
    
    
}
