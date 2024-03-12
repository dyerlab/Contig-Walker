//
//  ContentView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftUI


struct ContentView: View {
    var data: DataStore
    @State var isImporting: Bool = false
    @State var selectedGraph: Graph? = nil
    private var asDestination = false
    
    init() {
        self.data = DataStore()
    }
    
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading){
                List( data.graphs, id: \.self, selection: $selectedGraph){ graph in
                    
                    if( asDestination ) {  /// This one forces a full restart on the layout
                        NavigationLink(destination: {
                    
                            GraphView( graph: graph,
                                       loci: data.lociForGraph(graph: graph ) )
                            .padding()
                            .background( Color.tertiaryBackground )
                            
                        }, label: {
                            GraphLineView( graph: graph,
                                                  loci: data.lociForGraph( graph: graph ) )})
                    }
                    else {   /// This one picks up from the previous layout and modifies it...
                        NavigationLink(value: graph, label: {
                            GraphLineView( graph: graph,
                                           loci: data.lociForGraph( graph: graph ))
                        })
                    }

                }
                Text("  \(data.graphs.count) Topologies")
                    .font(.subheadline)
                    .padding(.leading )
            }
        } detail: {
            if( asDestination ) {
                HomeView()
            } else {
                if let selected = selectedGraph {
                    
                    ZStack {
                        GraphDisplayView(graph: selected )
                        VStack(alignment: .center) {
                            Spacer()
                            LocusSideView(loci: data.lociForGraph(graph: selected ))
                                .padding()
                            ContigView( locations: data.graphLocations,
                                        selected: data.locationForGraph(graph: selected) )
                        }
                        .padding()

                    }
                    .background( Color.tertiaryBackground )
                } else {
                    HomeView()
                }

            }

        }
        .onReceive( NotificationCenter.default.publisher(for: .importData), perform: { _ in
            isImporting = true
        })
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [ .json ],
                      allowsMultipleSelection: true, onCompletion: { result in
            
            switch result {
            case .success(let urls):
                data.importFromJSONs(urls: urls)
            case .failure:
                isImporting = false
            }

        })
        
        
    }
    
    
}


#Preview {
    ContentView()
}
