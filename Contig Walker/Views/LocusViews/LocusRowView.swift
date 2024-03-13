//
//  LocusRowView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct LocusRowView: View {
    var locus: Locus
    var body: some View {
        VStack(alignment: .leading){
            Text("\(locus.id)")
            Text("\(locus.coordinate) bp")
                .font(.footnote)
        }
    }
}

#Preview {
    LocusRowView(locus: Locus.DefaultLoci.first! )
}
