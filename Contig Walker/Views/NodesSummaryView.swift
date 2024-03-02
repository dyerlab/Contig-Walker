//
//  NodesSummaryView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/2/24.
//

import SwiftUI
import PresentationZen

struct NodesSummaryView: View {
    var summary: NodeSetSummarizer
    
    var body: some View {
        KeyValueTable(data: summary.dataPoints,
                      columnTypes: [.label, .yValue, .grouping],
                      columnHeaders: ["Node","Size","Group"])
    }
}

#Preview {
    NodesSummaryView(summary: NodeSetSummarizer(graph: Graph.DefaultJSON))
}
