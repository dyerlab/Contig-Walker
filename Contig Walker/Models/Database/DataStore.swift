//
//  DataStore.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Foundation

class DataStore: Codable {
    
    var graphs: [Graph]
    var loci: [Locus]
    
    enum CodingKeys: CodingKey {
        case graphs
        case loci
    }
    
    init(graphs: [Graph] = [], loci: [Locus] = []  ) {
        self.graphs = graphs
        self.loci = loci
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        graphs = try container.decode( [Graph].self, forKey: .graphs )
        loci = try container.decode( [Locus].self, forKey: .loci )
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode( graphs, forKey: .graphs )
        try container.encode( loci, forKey: .loci )
    }
    
    
    func lociForGraph( graph: Graph ) -> [Locus] {
        var ret = [Locus]()
        for locusID in graph.loci {
            if let theLoc = loci.first(where: {$0.id == locusID} ) {
                ret.append( theLoc)
            }
        }
        return ret
    }
    
}



extension DataStore {
    
    
    var exampleGraph: Graph {
        if let ret = self.graphs.first {
            return ret
        } else {
            return Graph.DefaultGraph
        }
    }
    
    static var DefaultDataStore: DataStore {
        let jsons = GraphJSONLoader.DefaultGraphs
        var loci = Set<Locus>()
        var graphs = [Graph]()
        
        for json in jsons {
            graphs.append( json.asGraph )
            for i in 0 ..< json.loci.count {
                let locus = Locus( id: json.loci[i],
                                   location: json.location[i],
                                   p: json.p[i],
                                   Ho: json.Ho[i],
                                   He: json.He[i] )
                if !loci.contains( locus ) {
                    loci.insert( locus )
                }
            }
        }
     
        return DataStore(graphs: graphs, loci: Array<Locus>(loci).sorted() )
    }
    
}
