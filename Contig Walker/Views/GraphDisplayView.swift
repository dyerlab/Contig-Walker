//
//  GraphDisplayView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Grape
import SwiftUI

struct GraphDisplayView: View {
    var graph: Graph
    @State private var isRunning = true
    @State private var graphState = ForceDirectedGraphState(
        initialIsRunning: true,
        initialModelTransform: .identity.scale(by: 1.2)
    )
    @State private var modelTransform: ViewportTransform = .identity.scale(by: 2.0)
    
    
    var body: some View {
        ForceDirectedGraph(
            states: graphState
        ) {
            
            Series(graph.nodes) { node in
                NodeMark(id: node.id)
                    .symbol(.circle)
                    .symbolSize(radius: CGFloat(node.size))  // TODO: Node size
                    .stroke()
                    .foregroundStyle(
                        GroupColors[ 0 ]
                            .shadow(
                                .inner(
                                    color: GroupColors[0].opacity(0.3),
                                    radius: 4,
                                    x: 0,
                                    y: 1.5
                                )
                            )
                    )
                    .richLabel(node.id,
                               alignment: .leading,
                               offset: .zero) {
                        self.getLabel( node.id,
                                       color: .secondary )
                    }
                            
            }
            
            Series(graph.edges) { l in
                LinkMark(from: l.source, to: l.target)
                    .foregroundStyle(.red)
            }
            
        } force: {
            ManyBodyForce(strength: -20)
            CenterForce()
            LinkForce(
                originalLength: .constant(35.0),
                stiffness: .weightedByDegree(k: { _, _ in 1.0})
            )
        }
    }
    
    
    @ViewBuilder
    func getLabel(_ text: String, color: Color) -> some View {
        Text(text)
            .font(.caption2)
            .padding(.vertical, 2.0)
            .padding(.horizontal, 2.0)
            .background(alignment: .center) {
                RoundedRectangle(cornerSize: .init(width: 12, height: 12))
                    .fill(.white)
                    .shadow(radius: 1.5, y: 1.0)
            }
            .padding()
            .foregroundColor( color )
    }
    
    
}

#Preview {
    GraphDisplayView(graph: Graph.DefaultGraph )
}
