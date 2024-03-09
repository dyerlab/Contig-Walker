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
    
    @State private var selectedSNP: Locus? = nil
    
    @State private var hoverLocation: CGPoint = .zero
    @State private var isHovering = false
    
    
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
            ret.append( DataPoint(x: Double(loc.location), y: loc.He, group: "He") )
            ret.append( DataPoint(x: Double(loc.location), y: (loc.He - loc.Ho)/loc.He, group: "F") )
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
                    x: .value("X Value", item.location  ),
                    y: .value("Y Value", 0.0 )
                )
                .symbolSize(0.0)
                .annotation(position: .automatic,
                            spacing: 0,
                            overflowResolution: .init(x: .padScale, y: .padScale)) {
                    Text("\(item.id )")
                        .font( .system(size: 9) )
                        .foregroundStyle(.secondary)
                        .rotationEffect(Angle(degrees: -45))
                    
                }
            }
            
        }
        .frame(maxHeight: 150 )
        .chartXScale(domain: scaleMin ... scaleMax )
        .chartLegend( position: .top )
        .chartYAxis{
            AxisMarks(values: [0.0, 0.25, 0.50 ] )
        }
        .chartXAxis { }
        /*
        .chartYAxisLabel(position: .bottom,
                         alignment: .center,
                         content: {
            Text("Diversity")
        } )
        .chartYAxis {
            AxisMarks( values: [0.0, 0.25, 0.50, 0.75 ])
        }
        .chartXScale( domain: scaleMin ... scaleMax )
        .chartXAxis {
            AxisMarks(position: .leading) { item in
                AxisValueLabel(orientation: .verticalReversed,
                               horizontalSpacing: 0.0,
                               verticalSpacing: 0.0)
            }
            
        }
        .frame( maxWidth: 150 )
         */
    }
    
    @ViewBuilder
    private func getSNPOverlay(locus: Locus) -> some View {
        VStack{
            Spacer()
            Text("p = \(locus.p); Ho = \(locus.Ho)")
        }
        .font(.system(size: 9.0))
        .foregroundStyle(.secondary)
        
    }
}

#Preview {
    LocusSideView( loci: Locus.DefaultLoci )
}
