//
//  GraphTests.swift
//  Contig WalkerTests
//
//  Created by Rodney Dyer on 2024-03-01.
//

@testable import Contig_Walker
import XCTest

final class GraphTests: XCTestCase {
    
    
    func testEmpty() throws {
        
        let graph = Graph()
        
        XCTAssertEqual( graph.nodes.count, 0 )
        XCTAssertEqual( graph.edges.count, 0 )
        XCTAssertEqual( graph.location.count, 0 )
        XCTAssertEqual( graph.loci.count, 0 )
        XCTAssertEqual( graph.p.count, 0 )
        XCTAssertEqual( graph.He.count, 0 )
        XCTAssertEqual( graph.Ho.count, 0 )
    }
    
    func testDefault() throws {
        
        let graph = Graph.DefaultGraph
        
        print("\(graph)")
        
    }

    
    func testDefaultGraphs() throws {
        let graphs = Graph.DefaultGraphs
        print("Loaded \(graphs.count) graphs")
    }
}
