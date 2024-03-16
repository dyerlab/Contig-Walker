//
//  MainWindowView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct MainWindowView: View {
    @State private var selected: SidebarCategory?
    @State private var isImporting = false
    var data: DataStore
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List( SidebarCategory.allCases, selection: $selected) { item in
            
                HStack {
                    Image(systemName: item.iconName )
                        .symbolRenderingMode( .palette )
                        .foregroundStyle( .blue, .secondary )
                    Text("\(item.localizedString)")
                }
                .disabled( data.isEmpty )
            }
            .listStyle( SidebarListStyle() )
            Spacer()
            Text("\(data.graphs.count) graphs")
                .font(.footnote)
        }, content: {
            switch selected {
            case .Loci:
                LocusListView(loci: data.loci )
            case .Map:
                Text("Maps")
            case .Graphs:
                GraphsListView(data: data )
            case .Traces:
                TracesListView(data: data )
            case nil:
                EmptyView()
            }
        }, detail: {
            HomeView()
        })
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
    MainWindowView(data: DataStore.DefaultDataStore )
        .frame( minWidth: 800)
}
