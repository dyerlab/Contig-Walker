//
//  EdgeSetSummarizer.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/2/24.
//

import Foundation
import PresentationZen


struct EdgeSetSummarizer: DataPointProvider {
    var dataPoints: [DataPoint]
    
    init( graph: Graph ) {
        dataPoints = [DataPoint]()
        for edge in graph.edges {
            dataPoints.append( DataPoint(category: "Edge", value: edge.weight, label: edge.source, group: edge.target))
        }
    }
}
