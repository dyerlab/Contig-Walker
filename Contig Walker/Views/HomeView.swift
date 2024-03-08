//
//  HomeView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack(alignment:.bottom) {
            Spacer()
            
            VStack(alignment: .leading, content: {
                Spacer()
                
                HStack {
                    
                    VStack(alignment: .leading) {
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
                .padding()
                
            })
        }
    }
}

#Preview {
    HomeView()
}
