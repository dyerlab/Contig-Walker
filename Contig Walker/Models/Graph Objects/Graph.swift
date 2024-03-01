//
//  Item.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import Foundation
import SwiftData

@Model
final class Graph {

    let nodes: [Node]
    let links: [Edge]
    
    init(nodes: [Node], links: [Edge]) {
        self.nodes = nodes
        self.links = links
    }
    
    
}



extension Graph {
    
    static var DefaultGraphs: [Graph] {
        let ret = [Graph]()
        let files = ["chr02_graph_0001.json",
                     "chr02_graph_0002.json",
                     "chr02_graph_0003.json",
                     "chr02_graph_0004.json",
                     "chr02_graph_0005.json",
                     "chr02_graph_0006.json",
                     "chr02_graph_0007.json",
                     "chr02_graph_0008.json",
                     "chr02_graph_0009.json",
                     "chr02_graph_0010.json",
                     "chr02_graph_0011.json",
                     "chr02_graph_0012.json",
                     "chr02_graph_0013.json",
                     "chr02_graph_0014.json",
                     "chr02_graph_0015.json",
                     "chr02_graph_0016.json",
                     "chr02_graph_0017.json",
                     "chr02_graph_0018.json",
                     "chr02_graph_0019.json",
                     "chr02_graph_0020.json",
                     "chr02_graph_0021.json",
                     "chr02_graph_0022.json",
                     "chr02_graph_0023.json",
                     "chr02_graph_0024.json",
                     "chr02_graph_0025.json",
                     "chr02_graph_0026.json",
                     "chr02_graph_0027.json",
                     "chr02_graph_0028.json",
                     "chr02_graph_0029.json",
                     "chr02_graph_0030.json",
                     "chr02_graph_0031.json",
                     "chr02_graph_0032.json",
                     "chr02_graph_0033.json",
                     "chr02_graph_0034.json",
                     "chr02_graph_0035.json",
                     "chr02_graph_0036.json",
                     "chr02_graph_0037.json",
                     "chr02_graph_0038.json",
                     "chr02_graph_0039.json",
                     "chr02_graph_0040.json",
                     "chr02_graph_0041.json",
                     "chr02_graph_0042.json",
                     "chr02_graph_0043.json",
                     "chr02_graph_0044.json",
                     "chr02_graph_0045.json",
                     "chr02_graph_0046.json",
                     "chr02_graph_0047.json",
                     "chr02_graph_0048.json",
                     "chr02_graph_0049.json",
                     "chr02_graph_0050.json",
                     "chr02_graph_0051.json",
                     "chr02_graph_0052.json",
                     "chr02_graph_0053.json",
                     "chr02_graph_0054.json",
                     "chr02_graph_0055.json",
                     "chr02_graph_0056.json",
                     "chr02_graph_0057.json",
                     "chr02_graph_0058.json",
                     "chr02_graph_0059.json",
                     "chr02_graph_0060.json",
                     "chr02_graph_0061.json",
                     "chr02_graph_0062.json",
                     "chr02_graph_0063.json",
                     "chr02_graph_0064.json",
                     "chr02_graph_0065.json",
                     "chr02_graph_0066.json",
                     "chr02_graph_0067.json",
                     "chr02_graph_0068.json",
                     "chr02_graph_0069.json",
                     "chr02_graph_0070.json",
                     "chr02_graph_0071.json",
                     "chr02_graph_0072.json",
                     "chr02_graph_0073.json",
                     "chr02_graph_0074.json",
                     "chr02_graph_0075.json",
                     "chr02_graph_0076.json",
                     "chr02_graph_0077.json",
                     "chr02_graph_0078.json",
                     "chr02_graph_0079.json",
                     "chr02_graph_0080.json",
                     "chr02_graph_0081.json",
                     "chr02_graph_0082.json",
                     "chr02_graph_0083.json",
                     "chr02_graph_0084.json",
                     "chr02_graph_0085.json",
                     "chr02_graph_0086.json",
                     "chr02_graph_0087.json",
                     "chr02_graph_0088.json",
                     "chr02_graph_0089.json",
                     "chr02_graph_0090.json",
                     "chr02_graph_0091.json",
                     "chr02_graph_0092.json",
                     "chr02_graph_0093.json",
                     "chr02_graph_0094.json",
                     "chr02_graph_0095.json",
                     "chr02_graph_0096.json",
                     "chr02_graph_0097.json",
                     "chr02_graph_0098.json",
                     "chr02_graph_0099.json",
                     "chr02_graph_0100.json" ]
        
        for file in files {
            if let path = Bundle.main.path(forResource: file, ofType: "json") {
                
                
                
            } else {
                print("Could not find path to \(file)")
            }
        }
            
        return ret
    }
    
}
