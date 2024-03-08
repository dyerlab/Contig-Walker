//
//  GraphsSideview.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/3/24.
//

import SwiftUI

struct GraphsSideview: View {
    var graphs: [Graph]
    var body: some View {
        List( graphs ) { graph in
            GraphLineView(graph: graph )
        }
        .listStyle( .sidebar )
    }
}

#Preview {
    GraphsSideview( graphs: DataStore.DefaultDataStore.graphs )
}
