//
//  GraphTests.swift
//  Contig WalkerTests
//
//  Created by Rodney Dyer on 2024-03-01.
//

@testable import Contig_Walker
import XCTest

final class GraphJSONLoaderTests: XCTestCase {
    
    
    func testEmpty() throws {
        
        let graph = GraphJSONLoader()
        
        XCTAssertEqual( graph.nodes.count, 0 )
        XCTAssertEqual( graph.edges.count, 0 )
        XCTAssertEqual( graph.location.count, 0 )
        XCTAssertEqual( graph.loci.count, 0 )
        XCTAssertEqual( graph.p.count, 0 )
        XCTAssertEqual( graph.Ho.count, 0 )
        XCTAssertEqual( graph.Hs.count, 0 )
        XCTAssertEqual( graph.Ht.count, 0 )
    }
    
    func testDefault() throws {
        
        let graph = GraphJSONLoader.DefaultGraph
        
        print("\(graph)")
        
    }

    
    func testDefaultGraphs() throws {
        let graphs = GraphJSONLoader.DefaultGraphs
        print("Loaded \(graphs.count) graphs")
    }
}
