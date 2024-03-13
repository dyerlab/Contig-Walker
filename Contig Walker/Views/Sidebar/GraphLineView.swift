//
//  GraphLineView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/3/24.
//

import SwiftUI

struct GraphLineView: View {
    var graph: Graph
    var loci: [Locus]
    var index: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Topology \(index)")
            HStack(alignment: .center, content: {
                VStack(alignment:.leading) {
                    Text("Nodes: \(graph.nodes.count); Edges: \(graph.edges.count)")
                        .font(.system(size: 11))
                    Text("\(loci.firstLocation)bp - \(loci.lastLocation)bp")
                        .font(.system(size: 9))
                }
                .foregroundStyle(.secondary)
            })
        }

        
    }
}

#Preview {
    GraphLineView(graph: DataStore.DefaultDataStore.exampleGraph,
                  loci: DataStore.DefaultDataStore.lociForGraph( graph: DataStore.DefaultDataStore.exampleGraph ),
                  index: 42 )
}