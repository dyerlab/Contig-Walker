//
//  Item.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import Foundation
import SwiftData

@Model
final class Graph: Codable  {

    let nodes: [Node]
    let edges: [Edge]
    let loci: [String]
    let location: [Int]
    let p: [Double]
    let Ho: [Double]
    let He: [Double]
    
    enum CodingKeys: CodingKey {
        case nodes
        case edges
        case loci
        case location
        case p
        case Ho
        case He
    }
    
    init(nodes: [Node]=[], edges: [Edge]=[], loci: [String]=[], location: [Int]=[], p: [Double]=[], Ho: [Double]=[], He: [Double]=[]) {
        self.nodes = nodes
        self.edges = edges
        self.loci = loci
        self.location = location
        self.p = p
        self.Ho = Ho
        self.He = He
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        nodes = try container.decode( Array.self, forKey: .nodes )
        edges = try container.decode( Array.self, forKey: .edges )
        loci = try container.decode( Array.self, forKey: .loci )
        location = try container.decode( Array.self, forKey: .location )
        p = try container.decode( Array.self, forKey: .p )
        Ho = try container.decode( Array.self, forKey: .Ho )
        He = try container.decode( Array.self, forKey: .He )
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self )
        try container.encode( nodes, forKey: .nodes )
        try container.encode( edges, forKey: .edges )
        try container.encode( loci, forKey: .loci )
        try container.encode( location, forKey: .location)
        try container.encode( p, forKey: .p )
        try container.encode( Ho, forKey: .Ho )
        try container.encode( He, forKey: .He )
    }
    
    
}


extension Graph: CustomStringConvertible {
    var description: String {
        return String("Graph: \(nodes.count) nodes, \(edges.count) edges, \(loci.count) loci.")
    }
}



extension Graph {
    
    static var DefaultGraph: Graph {
        let file = "graph_chr2_40bp_1"
        
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                if let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
                    
                    print("jsonData: \(jsonData)")
                    
                    let jd = JSONDecoder()
                    let graph = try jd.decode( Graph.self, from: jsonData )
                    return graph
                } else {
                    print("Cannot get json data")
                }
            } catch {
                fatalError("Could not load default graph from bundle, \(error.localizedDescription)")
            }
        } else {
            print("Could not get path to default graph json \(file).")
        }
        return Graph()
    }

    /*
    static var DefaultGraphs: [Graph] {
        let ret = [Graph]()
        let files = ["graph_chr2_40bp_1.json",
                     "graph_chr2_40bp_2.json",
                     "graph_chr2_40bp_3.json",
                     "graph_chr2_40bp_4.json",
                     "graph_chr2_40bp_5.json",
                     "graph_chr2_40bp_6.json",
                     "graph_chr2_40bp_7.json",
                     "graph_chr2_40bp_8.json",
                     "graph_chr2_40bp_9.json",
                     "graph_chr2_40bp_10.json",
                     "graph_chr2_40bp_11.json",
                     "graph_chr2_40bp_12.json",
                     "graph_chr2_40bp_13.json",
                     "graph_chr2_40bp_14.json",
                     "graph_chr2_40bp_15.json",
                     "graph_chr2_40bp_16.json",
                     "graph_chr2_40bp_17.json",
                     "graph_chr2_40bp_18.json",
                     "graph_chr2_40bp_19.json",
                     "graph_chr2_40bp_20.json",
                     "graph_chr2_40bp_21.json",
                     "graph_chr2_40bp_22.json",
                     "graph_chr2_40bp_23.json",
                     "graph_chr2_40bp_24.json",
                     "graph_chr2_40bp_25.json",
                     "graph_chr2_40bp_26.json",
                     "graph_chr2_40bp_27.json",
                     "graph_chr2_40bp_28.json",
                     "graph_chr2_40bp_29.json",
                     "graph_chr2_40bp_30.json",
                     "graph_chr2_40bp_31.json",
                     "graph_chr2_40bp_32.json",
                     "graph_chr2_40bp_33.json",
                     "graph_chr2_40bp_34.json",
                     "graph_chr2_40bp_35.json",
                     "graph_chr2_40bp_36.json",
                     "graph_chr2_40bp_37.json",
                     "graph_chr2_40bp_38.json",
                     "graph_chr2_40bp_39.json",
                     "graph_chr2_40bp_40.json",
                     "graph_chr2_40bp_41.json",
                     "graph_chr2_40bp_42.json",
                     "graph_chr2_40bp_43.json",
                     "graph_chr2_40bp_44.json",
                     "graph_chr2_40bp_45.json",
                     "graph_chr2_40bp_46.json",
                     "graph_chr2_40bp_47.json",
                     "graph_chr2_40bp_48.json",
                     "graph_chr2_40bp_49.json",
                     "graph_chr2_40bp_50.json"
                      ]
        
        for file in files {
            if let path = Bundle.main.path(forResource: file, ofType: "json") {
                
                
                
            } else {
                print("Could not find path to \(file)")
            }
        }
            
        return ret
    }
    */
}
