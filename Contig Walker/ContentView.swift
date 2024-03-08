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
    
    init() {
        self.data = DataStore.DefaultDataStore
    }
    
    var body: some View {
        NavigationSplitView {
            List( data.graphs, id: \.self, selection: $selectedGraph){ graph in
            
                NavigationLink(value: graph.id, label: {
                    GraphLineView(graph: graph)
                })
                
            }
        } detail: {
            if let selected = selectedGraph {
                GraphInfoView(graph: selected )
            } else {
                Text("Select a Graph")
            }
        }

    }
}


#Preview {
    ContentView()
}
