//
//  ContigView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/12/24.
//

import SwiftUI

struct ContigView: View {
    var locations: [Double]
    var selected: Double
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill( .blue.gradient )
                    .frame( height: 18 )
                    .position(x: geometry.size.width/2.0, y: 15.0 )

                ForEach( locations, id: \.self) { loc in
                    Rectangle()
                        .fill( .red.gradient )
                        .frame(width: 2, height: 22 )
                        .position( x: loc * geometry.size.width, y: 15.0 )
                }
                Rectangle()
                    .fill( .yellow.gradient )
                    .frame(width: 4, height: 26 )
                    .position( x: selected * geometry.size.width, y: 15.0 )
            }
            
        }
        .frame(maxHeight: 30.0)
        
    }
}

#Preview {
    ContigView( locations: [0.13, 0.22, 0.42, 0.56, 0.74, 0.95],
                selected: 0.33 )
}
