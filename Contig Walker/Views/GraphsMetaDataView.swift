//
//  GraphsMetaDataView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/10/24.
//

import SwiftUI
import PresentationZen

struct GraphsMetaDataView: View {
    var item: GraphMetaData
    var body: some View {
            VStack(alignment: .leading) {
                Text("Graph \(item.id)")
                    .font(.title2)
                KeyValueTable(data: item.dataPoints,
                              columnTypes: [.category, .label ],
                              columnHeaders: ["Parameter","Value"])
                .cardBackground()
            }
            
        

    }
}


#Preview {
    GraphsMetaDataView( item: Graph.DefaultGraph.metaData! )
        .padding(15)
        
}

