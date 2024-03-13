//
//  LocusView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct LocusListView: View {
    var loci: [Locus]
    var body: some View {
        
        if loci.isEmpty {
            Text("Load Topologies")
        } else {
            
            List( loci ) { locus in
                NavigationLink {
                    LocusDetailView( locus: locus )
                } label: {
                    LocusRowView( locus: locus )
                }
            }
        }
    }
}

#Preview {
    LocusListView(loci: DataStore.DefaultDataStore.loci )
}
