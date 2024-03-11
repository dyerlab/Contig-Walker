//
//  Item.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import Foundation
import SwiftData
import DLMatrix


class Graph : Codable, Identifiable {
    let id: UUID
    var nodes: [Node]
    var edges: [Edge]
    var loci: [String]
    var metaData: GraphMetaData?
    
    init(nodes: [Node]=[], edges: [Edge]=[], loci: [String] = [] ) {
        self.id = UUID()
        self.nodes = nodes
        self.edges = edges
        self.loci = loci
        
        let A = asMatrix()
        self.metaData = GraphMetaData(id: UUID(),
                                      numNodes: nodes.count,
                                      numEdges: edges.count,
                                      degree: Degree(A: A),
                                      closeness: Closeness(A: A),
                                      betweenness: Betweenness(A: A),
                                      diameter: Diameter(A: A))
         
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


extension Graph: MatrixConvertible {
    
    func asMatrix() -> DLMatrix.Matrix {
        let N = nodes.count
        let A = Matrix(N,N,0.0)
        let idx = getLinkIndices()
        
        for i in 0 ..< edges.count {
            A[ idx[i].0, idx[i].1 ] = edges[i].weight
            A[ idx[i].1, idx[i].0 ] = A[ idx[i].0, idx[i].1 ]
        }
        
        return A
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
