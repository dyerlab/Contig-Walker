//
//  Color.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Foundation
import SwiftUI

public extension Color {

    #if os(macOS)
    static let primaryBackground = Color(NSColor.windowBackgroundColor)
    static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
    static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
    static let alternativeBackgroundDark = Color(NSColor.alternatingContentBackgroundColors[1] )
    static let alternativeBackgroundLight = Color(NSColor.alternatingContentBackgroundColors.first! )
    #else
    static let primaryBackground = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    static let alternativeBackgroundDark = Color(UIColor.secondarySystemBackground)
    static let alternativeBackgroundLight = Color(UIColor.tertiarySystemBackground)
    #endif
}


