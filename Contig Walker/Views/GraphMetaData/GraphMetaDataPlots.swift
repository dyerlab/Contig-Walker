//
//  GraphMetaDataPlots.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-12.
//

import Charts
import SwiftUI
import PresentationZen

struct GraphMetaDataPlots: View {
    var data: DataStore
    
    var body: some View {
        
        VStack(alignment: .leading ) {
            Text("Found \(data.graphs.count)")
            Chart {
                ForEach( data.metaDataPoints(dataCategory: .Edges), id: \.self) { item in
                    
                    LineMark(
                        x: .value("X Value", item.xValue  ),
                        y: .value("Y Value", item.yValue )
                    )
                    
                }
            }
        }
    }
}

#Preview {
    GraphMetaDataPlots( data: DataStore.DefaultDataStore )
}
