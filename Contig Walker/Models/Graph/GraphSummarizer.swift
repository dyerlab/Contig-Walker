//
//  GraphSummarizer.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/2/24.
//

import Foundation
import PresentationZen

struct GraphSummarizer: DataPointProvider {
    
    var dataPoints: [DataPoint]
    
    init(graph: Graph) {
        dataPoints = [DataPoint]()
        dataPoints.append( DataPoint(category: "Nodes", value: Double(graph.nodes.count) ))
        dataPoints.append( DataPoint(category: "Edges", value: Double(graph.edges.count) ))
    }
    
}
