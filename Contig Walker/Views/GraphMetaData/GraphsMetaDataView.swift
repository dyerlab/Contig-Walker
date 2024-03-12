//
//  GraphsMetaDataView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/10/24.
//

import SwiftUI
import PresentationZen

struct GraphsMetaDataView: View {
    
    var idx: Int
    var item: GraphMetaData
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Topology \(idx)")
                    .font(.title2)
                KeyValueTable(data: item.dataPoints,
                              columnTypes: [.category, .label ],
                              columnHeaders: ["Parameter","Value"])
                .cardBackground()
                .frame(maxWidth: 220, maxHeight: 125)
            }
            
        

    }
}


#Preview {
    GraphsMetaDataView( idx: 2, item: Graph.DefaultGraph.metaData! )
        .padding(15)
        
}

