//
//  Item.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import Foundation
import SwiftData

class Graph : Codable, Identifiable {
    let id: UUID
    var nodes: [Node]
    var edges: [Edge]
    var loci: [String]
    
    init(nodes: [Node]=[], edges: [Edge]=[], loci: [String] = [] ) {
        self.id = UUID()
        self.nodes = nodes
        self.edges = edges
        self.loci = loci
    }
    
    
    /// Returns the Link indices of nodes for all edges
    func getLinkIndices() -> [(Int, Int)] {
        let linkIds = self.edges.map { l in
            ( nodes.firstIndex{l.source==$0.id}!, nodes.firstIndex{l.target==$0.id}!) }
        return linkIds
    }
    
    func weightForConnection( source: Int, target: Int) -> Double {
        if let edge = edges.filter( {$0.source == nodes[source].id && $0.target == nodes[target].id }).first {
            return edge.weight
        } else {
            return 1.0
        }
    }

    
}



extension Graph: CustomStringConvertible {
    var description: String {
        var ret = "Graph: \(nodes.count) nodes, \(edges.count) edges, \(loci.count) loci."
        ret += "Node:\n"
        for node in nodes {
            ret += "  \(node)\n"
        }
        ret += "Edges:\n"
        for edge in edges {
            ret += "  \(edge)\n"
        }
        return ret
    }
}


extension Graph: Equatable, Hashable {
    
    static func == (lhs: Graph, rhs: Graph) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine( self.id )
    }
    
    
}


extension Graph {
    
    static var DefaultGraph: Graph {
        let json = GraphJSONLoader.DefaultGraph
        return json.asGraph
    }
    
    static var DefaultGraphs: [Graph] {
        let jsons = GraphJSONLoader.DefaultGraphs
        var ret = [Graph]()
        for json in jsons {
            ret.append( json.asGraph )
        }
        return ret
    }
    
}
