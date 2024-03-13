//
//  TracesDetailView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import Charts
import SwiftUI
import PresentationZen

struct TracesDetailView: View {
    var dataCategory: GraphDataCategory
    private var dataPoints: [DataPoint]
    private var meanData: Double
    private var minX: Double
    private var maxX: Double
    
    init(dataCategory: GraphDataCategory, data: DataStore) {
        self.dataCategory = dataCategory
        self.dataPoints = data.metaDataPoints(dataCategory: dataCategory)
        self.meanData = dataPoints.compactMap( { $0.yValue }).mean
        if dataPoints.isEmpty {
            self.minX = 0.0
            self.maxX = 0.0
        } else {
            self.minX = dataPoints.compactMap( {$0.xValue }).min()!
            self.maxX = dataPoints.compactMap( {$0.xValue }).max()!
        }
    }
    
    
    var body: some View {
        VStack(alignment:.leading) {
            
            Text("\(dataCategory.rawValue)")
                .font(.title)
            
            Text("Data below are derived from \(dataPoints.count) topologies.  \(dataCategory.rawValue) is defined as:")
            Text("\(dataCategory.description)")
                .italic()
                .font(.caption)
                .padding(.leading,12)
            
            Chart {
                RuleMark(
                    y: .value("Mean Value", meanData)
                )
                .lineStyle( .init(dash: [5.0, 3.0 ]))
                .foregroundStyle( .red )
                
                ForEach( dataPoints ) { item in
                    LineMark(
                        x: .value("X Value", item.xValue),
                        y: .value("Y Value", item.yValue)
                    )
                    .lineStyle( .init( lineWidth: 1.0) )
                    PointMark(
                        x: .value("X Value", item.xValue),
                        y: .value("Y Value", item.yValue)
                    )
                }
            }
            .chartXAxisLabel(position: .bottom,
                             alignment: .center,
                             content: {
                Text("Position Along Contig (bp)")
                    .font(.title3)
            } )
            .chartYAxisLabel(position: .trailing,
                             alignment: .center,
                             content: {
                Text("\(dataCategory.rawValue)")
            })
        }
        .padding()
    }
}

#Preview {
    TracesDetailView( dataCategory: .Closeness,
                      data: DataStore.DefaultDataStore )
}
