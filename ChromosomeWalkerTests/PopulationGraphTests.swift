//
//  NodeTests.swift
//  ChromosomeWalkerTests
//
//  Created by Rodney Dyer on 2024-02-28.
//


import XCTest
@testable import ChromosomeWalker


final class PopulationGraphTests: XCTestCase {


    func testDefault() throws {
        if let graph = PopulationGraph.getGraph {
            print("found graph with \(graph.nodes.count) nodes and \(graph.edges.count) edges")
        } else {
            print("could not make graph")
        }
        
    }


}
