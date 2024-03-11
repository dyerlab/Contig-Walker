//
//  ChromosomeView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/10/24.
//


import SwiftUI


struct ChromosomeView: View {
    var data: [GraphMetaData]
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach( data, id: \.self ){ item in
                    GraphsMetaDataView( item: item )
                        .cardBackground()
                }
            }
       }
            
        
    }
}

/*
#Preview {
    ChromosomeView(data: DataStore.DefaultDataStore.graphsMetaData )
}
*/
