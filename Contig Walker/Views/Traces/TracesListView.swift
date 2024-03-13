//
//  TracesListView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct TracesListView: View {
    var data: DataStore
    @State private var selected: GraphDataCategory? = nil 
    
    var body: some View {
        if data.isEmpty {
            Text("Load topologies")
        } else {
            List( GraphDataCategory.allCases, selection: $selected) { item in
                NavigationLink {
                    TracesDetailView(dataCategory: item, data: data)
                } label: {
                    VStack(alignment: .leading) {
                        Text("\(item.localizedString)")
                        Text("\(item.description)")
                            .font(.footnote)
                    }

                }
            }

        }
    }
}

#Preview {
    TracesListView(data: DataStore.DefaultDataStore )
}
