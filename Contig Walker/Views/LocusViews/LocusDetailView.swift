//
//  LocusDetailView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI
import PresentationZen

struct LocusDetailView: View {
    var locus: Locus
    var data: [DataPoint] {
        var ret = [DataPoint]()

        ret.append( DataPoint( category: "mAF", value: 0.0, label: String(format: "%.4f", locus.q)))
        ret.append( DataPoint( category: "MAF", value: 0.0, label: String(format: "%.4f", locus.p)))
        
        ret.append( DataPoint( category: "Location", value: 0.0, label: String(locus.coordinate)))
        ret.append( DataPoint( category: "Ho", value: 0.0, label: String(format: "%.4f", locus.Ho)))
        ret.append( DataPoint( category: "He", value: 0.0, label: String(format: "%.4f", locus.He)))
        ret.append( DataPoint( category: "Hs", value: 0.0, label: String(format: "%.4f", locus.Hs)))
        ret.append( DataPoint( category: "Ht", value: 0.0, label: String(format: "%.4f", locus.Ht)))
        ret.append( DataPoint( category: "S", value: 0.0, label: String(format: "%.4f", locus.SW)))
        ret.append( DataPoint( category: "Fis", value: 0.0, label: String(format: "%.4f", locus.Fis)))
        ret.append( DataPoint( category: "Fst", value: 0.0, label: String(format: "%.4f", locus.Fst)))
        
        return ret
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(locus.id)")
                .font(.title)
            KeyValueTable( data: data,
                           columnTypes: [.category, .label],
                           columnHeaders: ["Parameter","Value"])
            .cardBackground()
            .frame(maxWidth: 200, maxHeight: 275)
        }
        .padding()
    }
}

#Preview {
    LocusDetailView(locus: Locus.DefaultLoci.first!)
}
