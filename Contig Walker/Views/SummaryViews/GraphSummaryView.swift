//
//  GraphSummaryView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/2/24.
//

import SwiftUI
import PresentationZen

struct GraphSummaryView: View {
    var summary: GraphSummarizer
    
    var body: some View {
        KeyValueTable(data: summary.dataPoints,
                      columnTypes: [.category, .yValue],
                      columnHeaders: ["Property","Value"],
                      formatString: "%.0f" )
    }
}

#Preview {
    GraphSummaryView(summary: GraphSummarizer(graph: Graph.DefaultGraph))
}
