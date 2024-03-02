//
//  GraphInfoView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/2/24.
//

import SwiftUI

struct GraphInfoView: View {
    var graph: Graph
    
    var body: some View {
        ScrollView {
            GraphSummaryView(summary: GraphSummarizer(graph: graph))
            NodesSummaryView(summary: NodeSetSummarizer(graph: graph))
            EdgesSummaryView(summary: EdgeSetSummarizer(graph: graph))
        }
    }
}

#Preview {
    GraphInfoView( graph: Graph.DefaultJSON )
}
