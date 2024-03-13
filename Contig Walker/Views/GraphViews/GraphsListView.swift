//
//  GraphsListView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct GraphsListView: View {
    var data: DataStore
    
    var body: some View {
        List( data.graphs ) { graph in
            NavigationLink {
                GraphDetailView( data: data,
                                 graph: graph )
            } label: {
                GraphLineView( graph: graph,
                               loci: data.lociForGraph(graph: graph) )
            }
        }
    }
}

#Preview {
    GraphsListView( data: DataStore.DefaultDataStore )
}
