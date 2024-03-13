//
//  GraphDetailView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct GraphDetailView: View {
    var data: DataStore
    var graph: Graph
    
    
    var body: some View {
        ZStack {
            GraphDisplayView(graph: graph )
            VStack(alignment: .center) {
                Spacer()
                LocusSideView(loci: data.lociForGraph(graph: graph ))
                ContigView( locations: data.graphLocations,
                            selected: data.locationForGraph(graph: graph) )
            }
            .padding()
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
        .background( Color.tertiaryBackground )
    }
}

#Preview {
    GraphDetailView( data: DataStore.DefaultDataStore,
                     graph: DataStore.DefaultDataStore.graphs.first! )
}
