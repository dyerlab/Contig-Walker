//
//  SidebarItem.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-13.
//

import Foundation

enum SidebarCategory: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Loci = "Loci"
    case Map = "Maps"
    case Graphs = "Graphs"
    case Traces = "Traces"
    
    var localizedString: String {
        return self.rawValue
    }
    
    var iconName: String {
        switch self {
        case .Loci:
            return "slider.horizontal.3"
        case .Map:
            return "mappin.and.ellipse"
        case .Graphs:
            return "point.3.filled.connected.trianglepath.dotted"
        case .Traces:
            return "chart.xyaxis.line"
        }
    }
    
    
}
