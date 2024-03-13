//
//  GraphMetaDataType.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-12.
//

import Foundation

/**
 The kinds of data that is derived from a topology and used for traces.
 */
enum GraphDataCategory: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Edges = "Edges Count"
    case Degree = "Degree Centrality"
    case Closeness = "Node Closeness"
    case Betweenness = "Node Betweenness"
    case Diameter = "Graph Diameter"
    
    var localizedString: String {
        return self.rawValue
    }
    
    
}


extension GraphDataCategory: CustomStringConvertible {
    var description: String {
        switch self {
        case .Edges:
            return "The number of edges in the topology."
        case .Degree:
            return "The average number of edges on each node."
        case .Closeness:
            return "The reciprocal of the sum of the length of the shortest paths between a node and all other nodes."
        case .Betweenness:
            return "The number of shortest paths through the topology that traverse each node."
        case .Diameter:
            return "The length of the shortest path throught the topology, which is largest in magnitude.sd"
        }
        
    }
}
