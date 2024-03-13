//
//  EmptyView.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(minWidth: 0, idealWidth: 1, maxWidth: 1)
    }
}

#Preview {
    EmptyView()
}

