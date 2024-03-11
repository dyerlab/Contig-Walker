//
//  GraphsMetaDataView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/10/24.
//

import SwiftUI


struct GraphsMetaDataView: View {
    var item: GraphMetaData
    var body: some View {
            VStack(alignment: .leading) {
                Text("Graph \(item.id)")
                    .font(.title3)
                Text("N: \(item.numNodes); E: \(item.numEdges)")
                    .font(.subheadline)
            }
            .padding(5)
            .background( Color("CardBackgroundColor") )
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.4), radius: 5)
    }
}


#Preview {
    GraphsMetaDataView( item: Graph.DefaultGraph.metaData! )
        .padding(15)
        
}

