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
                Logo()
                .padding()
                
            })
        }
    }
}

#Preview {
    HomeView()
}
