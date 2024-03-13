//
//  DataStoreTests.swift
//  Contig WalkerTests
//
//  Created by Rodney Dyer on 2024-03-12.
//

import XCTest
@testable import Contig_Walker

final class DataStoreTests: XCTestCase {

    func testEmpty() throws {
        let ds = DataStore()
        
        XCTAssertEqual( ds.graphs.count, 0)
        XCTAssertEqual( ds.loci.count, 0 )
    }
    
    func testDefault() throws {
        
        let ds = DataStore.DefaultDataStore
        
        XCTAssertEqual( ds.graphs.count, 100 )
        XCTAssertEqual( ds.loci.count, 2020  )
        XCTAssertEqual( ds.metaData.count, 100)
        
        if let g = ds.graphs.first {
            print( "Graph: \(g)")
        } else {
            print( "ERROR GRAPH WAS NIL")
        }
        
        XCTAssertEqual( ds.graphs.first!.loci.count, 40 )
        
        let gmd_edges = ds.metaDataPoints(dataCategory: .Edges)
        XCTAssertEqual( gmd_edges.count, 100)
        print("GMD.Edges")
        for edge in gmd_edges {
            print( edge)
        }

        
    }


}
