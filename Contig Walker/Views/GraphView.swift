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
        
        HStack(alignment: .center, content: {
            LocusSideView(loci: loci)
            GraphDisplayView(graph: graph )
        })
        .navigationTitle( graph.id.uuidString )
    }
}

#Preview {
    GraphView( graph: DataStore.DefaultDataStore.exampleGraph,
               loci: DataStore.DefaultDataStore.lociForGraph(graph: DataStore.DefaultDataStore.exampleGraph) )
    .frame( minWidth: 800, minHeight: 600)
}
