//
//  ContentView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftUI


struct ContentView: View {
    var data: DataStore
    @State var selectedGraph: Graph? = nil
    private var asDestination = false
    
    init() {
        self.data = DataStore.DefaultDataStore
    }
    
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading){
                List( data.graphs, id: \.self, selection: $selectedGraph){ graph in
                    
                    if( asDestination ) {
                        NavigationLink(destination: {
                    
                            GraphView( graph: graph,
                                       loci: data.lociForGraph(graph: graph ) )
                            .padding()
                            .background( Color.tertiaryBackground )
                            
                        }, label: {
                            GraphLineView( graph: graph,
                                                  loci: data.lociForGraph( graph: graph ) )})

                    }
                    else {
                        NavigationLink(value: graph, label: {
                            GraphLineView( graph: graph,
                                           loci: data.lociForGraph( graph: graph ) )
                        })
                    }

                }
                Text("  \(data.graphs.count) Topologies")
                    .font(.subheadline)
                    .padding(.leading )
            }
        } detail: {
            if( asDestination ) {
                HomeView()
            } else {
                if let selected = selectedGraph {
                    GraphView( graph: selected,
                               loci: data.lociForGraph(graph: selected ) )
                    .padding()
                    .background( Color.tertiaryBackground )
                } else {
                    HomeView()
                }

            }

        }
        
    }
    
    
}


#Preview {
    ContentView()
}
