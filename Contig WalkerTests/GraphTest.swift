//
//  GraphTest.swift
//  Contig WalkerTests
//
//  Created by Rodney Dyer on 3/8/24.
//

@testable import Contig_Walker
import XCTest
import SwiftData 
import DLMatrix

final class GraphTest: XCTestCase {



    func testInitFromJSON() throws {
        
        let graph = Graph.DefaultGraph
        
        print("\(graph)")
        
        XCTAssertEqual( graph.nodes.count, 29 )
        XCTAssertEqual( graph.edges.count, 83 )
        XCTAssertEqual( graph.loci.count, 40 )
    }
    
    
    func testInitFromRaw() throws {
        
        let nodes = [ Node(id: "A", size: 1, longitude: 32.3, latitude: 112.2, group: "All"),
                      Node(id: "B", size: 2, longitude: 32.3, latitude: 112.2, group: "All"),
                      Node(id: "C", size: 3, longitude: 32.3, latitude: 112.2, group: "All"),
                      Node(id: "D", size: 4, longitude: 32.3, latitude: 112.2, group: "All") ]
        
        let edges = [ Edge(source: "A", target: "B", weight: 1.0),
                      Edge(source: "A", target: "C", weight: 2.0),
                      Edge(source: "B", target: "C", weight: 3.0),
                      Edge(source: "C", target: "D", weight: 4.0) ]
        
        let graph = Graph(nodes: nodes, edges: edges, loci: ["Locus1","Locus2","Locus3"] )
        print("Graph: \(graph)")
     
        let A = graph.asMatrix()
        print("Adjacency")
        print("\(A)")
        
        let D = ShortestPaths(A: A)
        print("Shortest Paths")
        print("\(D)")
        
        let C = Closeness(A: A)
        print("Closeness")
        print("\(C)")
        
        let B = Betweenness(A: A)
        print("Betweenness")
        print("\(B)")
    }


}
