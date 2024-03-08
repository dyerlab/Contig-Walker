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
    
    var dataPoints: [DataPoint] {
        var ret = [DataPoint]()
        
        for loc in loci {
            ret.append( DataPoint(x: loc.p, y: Double(loc.location), group: "p") )
            ret.append( DataPoint(x: loc.He, y: Double(loc.location), group: "He") )
            ret.append( DataPoint(x: loc.Ho, y: Double(loc.location), group: "Ho") )
        }
        return ret
    }
    
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
                LineMark(
                    x: .value("X Value", item.He),
                    y: .value("Y Value", item.location)
                )
                .lineStyle( .init( lineWidth: 1.0, dash: [1,2]) )
                .opacity( 0.25)
            }
            
            
            
            ForEach( loci, id: \.self) { item in
                PointMark(
                    x: .value("X Value", item.He  ),
                    y: .value("Y Value", item.location )
                )
                .symbolSize( 6 )
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
            Text("Diversity")
        } )
        .chartXAxis {
            AxisMarks( values: .automatic(desiredCount: 3))
        }
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
