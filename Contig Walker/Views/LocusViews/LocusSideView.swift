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
    var scaleMin: UInt
    var scaleMax: UInt
    
    @State private var selectedSNP: Locus? = nil
    
    @State private var hoverLocation: CGPoint = .zero
    @State private var isHovering = false
    
    @State private var showingAe = false
    @State private var showingP = false
    @State private var showingHo = false
    @State private var showingHe = true
    @State private var showingHs = true
    @State private var showingFis = false
    @State private var showingFst = true
    @State private var showingSW = true
    
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
            if showingP {
                ret.append( DataPoint(x: Double(loc.coordinate), y: loc.p, group: "p") )
            }
            if showingSW {
                ret.append( DataPoint(x: Double(loc.coordinate), y: loc.SW, group: "SW") )
            }
            if showingHo {
                ret.append( DataPoint(x: Double(loc.coordinate), y: loc.Ho, group: "Ho") )
            }
            if showingHs {
                ret.append( DataPoint(x: Double(loc.coordinate), y: loc.Hs, group: "Hs") )
            }
            if showingFis {
                ret.append( DataPoint(x: Double(loc.coordinate), y: loc.Fis, group: "Fis") )
            }
            if showingFst {
                ret.append( DataPoint(x: Double(loc.coordinate), y: loc.Fst, group: "Fst") )
            }
            
        }
        return ret
    }
    
    init(loci: [Locus]) {
        let rng = loci.range
        let span = UInt((rng.1 - rng.0) / 20)
        
        self.loci = loci
        self.scaleMin = rng.0 - span
        self.scaleMax = rng.1 + span
    }
    
    
    
    var body: some View {
        HStack {
            
            Chart {
            
                ForEach( loci, id: \.self) { item in
                    PointMark(
                        x: .value("X Value", item.coordinate  ),
                        y: .value("Y Value", 0.0 )
                    )
                    .symbolSize(1.0)
                    .foregroundStyle( .secondary )
                    .annotation(position: .trailing,
                                spacing: 0) {
                        Text(" \(item.id )")
                            .font( .system(size: 9) )
                            .foregroundStyle(.tertiary)
                            .rotationEffect(Angle(degrees: -90), anchor: .leading)
                            .opacity(0.75)
                    }
                }
                
                ForEach( dataPoints ) { item in
                    LineMark(
                        x: .value("X Value", item.xValue),
                        y: .value("Y Value", item.yValue)
                    )
                    .lineStyle( .init( lineWidth: 2.0) )
                    .foregroundStyle(by: .value("group", item.grouping) )
                }
            
            }
            .frame(maxHeight: 150 )
            .chartXScale(domain: scaleMin ... scaleMax )
            .chartLegend( position: .top )
            .chartYAxis{
                // AxisMarks(values: [0.0, 0.25, 0.50 ] )
            }
            .chartXAxis { }
            .frame(maxWidth: .infinity)
    
            
            VStack(alignment: .trailing) {
                Toggle(isOn: $showingP, label: {
                    Text("p")
                })
                .toggleStyle( .switch )
                .controlSize( .mini )
                Toggle(isOn: $showingSW, label: {
                    Text("S")
                })
                .toggleStyle( .switch )
                .controlSize( .mini )
                Toggle(isOn: $showingHo, label: {
                    Text("Ho")
                })
                .toggleStyle( .switch )
                .controlSize( .mini )
                Toggle(isOn: $showingHs, label: {
                    Text("Hs")
                })
                .toggleStyle( .switch )
                .controlSize( .mini )
                Toggle(isOn: $showingFis, label: {
                    Text("Fis")
                })
                .toggleStyle( .switch )
                .controlSize( .mini )
                Toggle(isOn: $showingFst, label: {
                    Text("Fst")
                })
                .toggleStyle( .switch )
                .controlSize( .mini )
            }
            .frame(maxWidth: 150)
        }
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
        .frame(minWidth: 1900)
}
