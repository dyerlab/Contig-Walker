//
//  GraphLineView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/3/24.
//

import SwiftUI

struct GraphLineView: View {
    var graph: Graph
    var body: some View {
        HStack(alignment: .center, content: {
            //Image(systemName: "scale.3d")
            Image(systemName: "point.3.filled.connected.trianglepath.dotted")
                .symbolRenderingMode(.palette)
                .foregroundStyle( .blue, .primary )
                .font(.largeTitle)
            VStack(alignment:.leading) {
                Text("Nodes: \(graph.nodes.count); Edges: \(graph.edges.count)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Text("\(graph.loci.range.0) ↔︎ \(graph.loci.range.1)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        })
        
    }
}

#Preview {
    GraphLineView(graph: Graph.DefaultGraph)
}
