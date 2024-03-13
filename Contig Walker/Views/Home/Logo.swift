//
//  Logo.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/11/24.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        HStack(spacing: 0.0) {
            VStack(alignment: .trailing) {
                Text("Chromosome Walker")
                    .font(.largeTitle)
                Text("The shape of genetic covariance")
            }

            ZStack(alignment: .bottomTrailing, content: {
                HStack{
                    Image(systemName: "figure.walk")
                        .rotationEffect(.degrees(-90))
                        .font(.largeTitle)
                    Spacer()
                }
                HStack{
                    Spacer()
                    Image(systemName: "line.diagonal")
                        .rotationEffect(.degrees(-45))
                        .font(.largeTitle)
                        .foregroundColor( .accentColor )
                }
            })
            .frame(width:40, height:40)
            .scaleEffect(x: -1, y: 1)  // flip horizontally

        }
    }
}

#Preview {
    Logo()
}
