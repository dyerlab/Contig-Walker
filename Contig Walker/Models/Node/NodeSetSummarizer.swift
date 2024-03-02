//
//  NodeSetSummarizer.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/2/24.
//

import Foundation
import PresentationZen

struct NodeSetSummarizer : DataPointProvider {
    
    /// Sole variable
    var dataPoints: [DataPoint] = []
    
    
    init( graph: Graph ) {
        
        for node in graph.nodes {
            let pt = DataPoint(category: "Node", value: node.size, label: node.id, group: node.group)
            dataPoints.append( pt )
        }
        
    }
    
}
