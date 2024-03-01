//
//  NodeTests.swift
//  Contig WalkerTests
//
//  Created by Rodney Dyer on 2024-03-01.
//

@testable import Contig_Walker
import XCTest

final class NodeTests: XCTestCase {


    func testEmpty() throws {
        
        let node = Node(id: "Bob", size: 23.3, longitude: 32.97, latitude: -123.3, group: "All")
        print("\(node)")
        
    }

    
    func testJSONNode() throws {
        
        let node = Node.DefaultJSONNode
        print("\(node)")
        
    }

}
