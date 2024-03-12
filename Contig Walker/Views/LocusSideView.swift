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
    
    @State private var showingAe = false
    @State private var showingP = false
    @State private var showingHo = false
    @State private var showingHe = true
    @State private var showingHs = true
    @State private var showingFis = false
    @State private var showingFst = true
    
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
        let span = (rng.1 - rng.0) / 20
        
        self.loci = loci
        self.scaleMin = rng.0 - span
        self.scaleMax = rng.1 + span
    }
    
    
    
    var body: some View {
        HStack {
            
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
                        x: .value("X Value", item.coordinate  ),
                        y: .value("Y Value", 0.0 )
                    )
                    .symbolSize(0.0)
                    .annotation(position: .automatic,
                                spacing: 0,
                                overflowResolution: .init(x: .padScale, y: .fit)) {
                        Text("\(item.id )")
                            .font( .system(size: 9) )
                            .foregroundStyle(.secondary)
                            .rotationEffect(Angle(degrees: -90))
                        
                    }
                }
                
            }
            .frame(maxHeight: 150 )
            .chartXScale(domain: scaleMin ... scaleMax )
            .chartLegend( position: .top )
            .chartYAxis{
                // AxisMarks(values: [0.0, 0.25, 0.50 ] )
            }
            .chartXAxis { }
            .padding( .bottom, 15  )
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
            
            
            VStack(alignment: .leading) {
                Toggle(isOn: $showingP, label: {
                    Text("p")
                })
                .toggleStyle( .switch)
                Toggle(isOn: $showingHo, label: {
                    Text("Ho")
                })
                .toggleStyle( .switch)
                Toggle(isOn: $showingHs, label: {
                    Text("Hs")
                })
                .toggleStyle( .switch)
                Toggle(isOn: $showingFis, label: {
                    Text("Fis")
                })
                .toggleStyle( .switch)
                Toggle(isOn: $showingFst, label: {
                    Text("Fst")
                })
                .toggleStyle( .switch)
            }
            

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
}
