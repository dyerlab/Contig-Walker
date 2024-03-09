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
    
    var plotColor: Color {
        #if os(visionOS)
        return .white
        #else
        return .blue
        #endif
        
    }
    
    
    var dataPoints: [DataPoint] {
        var ret = [DataPoint]()
        
        for loc in loci {
            ret.append( DataPoint(x: loc.He, y: Double(loc.location), group: "He") )
            ret.append( DataPoint(x: (loc.He - loc.Ho)/loc.He, y: Double(loc.location), group: "F") )
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
            
            ForEach( dataPoints ) { item in
                LineMark(
                    x: .value("X Value", item.xValue),
                    y: .value("Y Value", item.yValue)
                )
                .lineStyle( .init( lineWidth: 2.0) )
                .opacity( 0.25)
                .foregroundStyle(by: .value("group", item.grouping) )
            }
            
            
            
            ForEach( loci, id: \.self) { item in
                PointMark(
                    x: .value("X Value", 1.0  ),
                    y: .value("Y Value", item.location )
                )
                .symbolSize(0.0)
                .annotation(position: .leading) {
                    Text("\(item.id )")
                        .font( .footnote )
                        .foregroundStyle(.secondary)
                        .help("This is the help text")
                }
            }
        }
        .chartXAxisLabel(position: .bottom,
                         alignment: .center,
                         content: {
            Text("Diversity")
        } )
        .chartXAxis {
            AxisMarks( values: [0.0, 0.25, 0.50, 0.75 ])
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
