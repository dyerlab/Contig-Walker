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
            Text("\(item.startingBP) - \(item.endingBP)")
                .font(.system(size: 9))
        }
        .padding()
    }
}

#Preview {
    GraphsMetaDataView( item: GraphMetaData.DefaultMetaData )
}
