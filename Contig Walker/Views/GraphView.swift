//
//  GraphView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import SwiftUI

struct GraphView: View {
    var graph: Graph
    var loci: [Locus]
    
    var body: some View {
        
        VStack(alignment: .center, content: {
            GraphDisplayView(graph: graph )
            LocusSideView(loci: loci)
                .padding()
        })
        .navigationTitle( graph.id.uuidString )
    }
}

#Preview {
    GraphView( graph: DataStore.DefaultDataStore.exampleGraph,
               loci: DataStore.DefaultDataStore.lociForGraph(graph: DataStore.DefaultDataStore.exampleGraph) )
    .frame( minWidth: 800, minHeight: 600)
}
