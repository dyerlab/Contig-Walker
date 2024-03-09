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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Population Graph")
            HStack(alignment: .center, content: {
                /*
                Image(systemName: "point.3.filled.connected.trianglepath.dotted")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle( .blue, .primary )
                    .font(.title2)
                 */
                
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
                  loci: DataStore.DefaultDataStore.lociForGraph(graph: DataStore.DefaultDataStore.exampleGraph) )
}
