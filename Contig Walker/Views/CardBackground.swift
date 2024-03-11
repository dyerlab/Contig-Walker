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
            .background(Color("CardBackground"))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}
