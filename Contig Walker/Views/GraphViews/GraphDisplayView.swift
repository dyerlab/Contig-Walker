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
        
        
        VStack {
        #if os(visionOS)
            TabView {
                VolumetricGraphView(graph: graph )
                    .tabItem {
                        Label("", systemImage: "view.3d")
                    }
                FlatlandGraphView(graph: graph )
                    .tabItem {
                        Label("", systemImage: "view.2")
                    }
                
            }
        #else
        FlatlandGraphView(graph: graph )
        #endif

        }
        
    }
    
    
}

#Preview {
    GraphDisplayView(graph: Graph.DefaultGraph )
}
