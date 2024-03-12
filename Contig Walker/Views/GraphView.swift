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
        GraphDisplayView(graph: graph )
            .navigationTitle( graph.id.uuidString )
            .toolbar {
                ToolbarItem(placement: .automatic, content: {
                    Button(action: {
                        NotificationCenter.default.post(name: .toggleLabels, object: nil)
                    }, label: {
                        Image(systemName: "123.rectangle")
                    })
                })
                ToolbarItem(placement: .automatic, content: {
                    Button(action: {
                        print("other button")
                    }, label: {
                        Image(systemName: "sidebar.trailing" )
                    })
                })
            }
    }
}

#Preview {
    GraphView( graph: DataStore.DefaultDataStore.exampleGraph,
               loci: DataStore.DefaultDataStore.lociForGraph(graph: DataStore.DefaultDataStore.exampleGraph) )
    .frame( minWidth: 800, minHeight: 600)
}
