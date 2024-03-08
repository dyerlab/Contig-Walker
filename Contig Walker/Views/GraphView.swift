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
        VStack(alignment:.leading){
            Text("Graph")
                .font(.largeTitle)
            Text("ID: \(graph.id.uuidString)")
            HStack(alignment: .center, content: {
                LocusSideView(loci: loci)
                GraphInfoView(graph: graph )
            })
        }
    }
}

#Preview {
    GraphView( graph: DataStore.DefaultDataStore.exampleGraph,
               loci: DataStore.DefaultDataStore.lociForGraph(graph: DataStore.DefaultDataStore.exampleGraph) )
}
