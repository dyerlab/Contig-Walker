//
//  MainWindowView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct MainWindowView: View {
    @State private var selected: SidebarCategory?
    var data: DataStore
    
    init() {
        data = DataStore.DefaultDataStore
    }
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List( SidebarCategory.allCases, selection: $selected) { item in
            
                HStack {
                    Image(systemName: item.iconName )
                        .symbolRenderingMode( .palette )
                        .foregroundStyle( .blue, .secondary )
                    Text("\(item.localizedString)")
                }
            }
            .listStyle( SidebarListStyle() )
            
        }, content: {
            switch selected {
            case .Loci:
                LocusListView(loci: data.loci )
            case .Map:
                Text("Maps")
            case .Graphs:
                GraphsListView(data: data )
            case nil:
                EmptyView()
            }
        }, detail: {
            HomeView()
        })
    }
}

#Preview {
    MainWindowView()
}
