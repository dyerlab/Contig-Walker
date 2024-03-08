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
    
    var body: some View {
        
        #if os(visionOS)
        VolumetricGraphView(graph: graph )
        #else
        FlatlandGraphView(graph: graph )
        #endif
        
    }
    
    
}

#Preview {
    GraphDisplayView(graph: Graph.DefaultGraph )
}
