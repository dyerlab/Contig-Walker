//
//  LocusSideView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Charts
import SwiftUI
import PresentationZen

struct LocusSideView: View {
    var loci: [Locus]
    var scaleMin: Int
    var scaleMax: Int
    
    init(loci: [Locus]) {
        let rng = loci.range
        let span = (rng.1 - rng.0) / 20
        
        self.loci = loci
        self.scaleMin = rng.0 - span
        self.scaleMax = rng.1 + span
    }
    
    
    
    var body: some View {
        Chart {
            ForEach( loci, id: \.self) { item in
                PointMark(
                    x: .value("X Value", item.He  ),
                    y: .value("Y Value", item.location )
                )
                .symbolSize( item.p*100 )
                .annotation(position: .trailing) {
                    Text("\(item.id )")
                        .font( .footnote )
                        .foregroundStyle(.secondary)
                }
            }
        }
        .chartXAxisLabel(position: .bottom,
                         alignment: .center,
                         content: {
            Text("SNP Diversity")
        } )
        .chartYScale( domain: scaleMin ... scaleMax )
        .chartYAxis {
            AxisMarks(position: .leading) { item in
                AxisValueLabel(orientation: .verticalReversed,
                               horizontalSpacing: 0.0,
                               verticalSpacing: 0.0)
            }
            
        }
        .frame( maxWidth: 150 )
    }
}

#Preview {
    LocusSideView( loci: Locus.DefaultLoci )
        .frame( minHeight: 800 )
}
