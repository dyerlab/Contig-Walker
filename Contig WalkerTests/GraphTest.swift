//
//  GraphTest.swift
//  Contig WalkerTests
//
//  Created by Rodney Dyer on 3/8/24.
//

@testable import Contig_Walker
import XCTest
import SwiftData 

final class GraphTest: XCTestCase {



    func testInitFromJSON() throws {
        
        let graph = Graph.DefaultGraph
        
        print("\(graph)")
        
        XCTAssertEqual( graph.nodes.count, 29 )
        XCTAssertEqual( graph.edges.count, 69 )
        XCTAssertEqual( graph.loci.count, 40 )
    }


}
