//
//  Item.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import Foundation
import SwiftData

@Model
class Graph {
    
    let nodes: [Node]
    let edges: [Edge]
    let loci: [Locus]
    
    init(nodes: [Node]=[], edges: [Edge]=[], loci: [Locus] = [] ) {
        self.nodes = nodes
        self.edges = edges
        self.loci = loci
    }
    
    init( json: GraphJSONLoader ) {
        var theLoci = [Locus]()
        for i in 0 ..< json.loci.count {
            let locus = Locus(name: json.loci[i],
                              location: json.location[i],
                              p: json.p[i],
                              Ho: json.Ho[i],
                              He: json.He[i] )
            theLoci.append( locus )
        }
        self.nodes = json.nodes
        self.edges = json.edges
        self.loci = theLoci
        
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





extension Graph {
    
    
    static var DefaultGraph: Graph {
        return Graph(json: GraphJSONLoader.DefaultGraph )
    }
    
    static var DefaultGraphs: [Graph] {
        var ret = [Graph]()
        let jsons = GraphJSONLoader.DefaultGraphs
        
        for json in jsons {
            ret.append( Graph(json: json) )
        }
        
        return ret
    }
    
    
}

