//
//  CardBackground.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-11.
//


import SwiftUI

// view modifier
struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background( Color("CardBackgroundColor") )
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.4), radius: 5)
    }
}
