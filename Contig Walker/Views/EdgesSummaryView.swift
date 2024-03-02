//
//  EdgesSummaryView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/2/24.
//

import SwiftUI
import PresentationZen

struct EdgesSummaryView: View {
    var summary: EdgeSetSummarizer
    
    var body: some View {
        KeyValueTable(data: summary.dataPoints,
                      columnTypes: [.label, .grouping, .yValue],
                      columnHeaders: ["Source","Destination","Weight"])
    }
}

#Preview {
    EdgesSummaryView( summary: EdgeSetSummarizer(graph: Graph.DefaultJSON))
}
