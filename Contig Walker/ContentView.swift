//
//  ContentView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2/28/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var graphs: [Graph]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach( graphs ) { graph in
                    NavigationLink {
                        GraphView( graph: graph  )
                    } label: {
                        Text("\(graph.id.uuidString)")
                    }
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
        } detail: {
            Text("Select a graph")
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [Graph.self], inMemory: true)
}
