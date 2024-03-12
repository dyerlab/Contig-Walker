//
//  DataStore.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Foundation
import PresentationZen

class DataStore: Codable {
    
    var graphs: [Graph]
    var loci: [Locus]
    
    var metaData: [GraphMetaData] {
        return graphs.compactMap({ $0.metaData })
    }
    
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
    
    
    func importFromJSONs(files: [URL]) {
        print("DataStore::importFromJSONs")
    }
    
}




/// Barfing up info on the graphs
extension DataStore : DataPointProvider {
    
    /*
    var graphsMetaData: [GraphMetaData] {
        var ret = [GraphMetaData]()
        
        for i in 0 ..< graphs.count {
            let graph = graphs[i]
            let locusRange = lociForGraph(graph: graph).range
            let meta = GraphMetaData(numNodes: graph.nodes.count,
                                     numEdges: graph.edges.count, 
                                     startingBP: locusRange.0,
                                     endingBP: locusRange.1)
            ret.append( meta )
        }
        
        return ret
    }
     */
    
    var dataPoints: [DataPoint] {
        var ret = [DataPoint]()
        for i in 0 ..< graphs.count  {
            let graph = graphs[i]
            let r = lociForGraph(graph: graph).range
            let pt = DataPoint( x: Double(r.0 + ( r.1 - r.0 )/2),
                                y: 1.0,
                                label: String("Graph \(i)") )
            ret.append( pt )
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
        let ret = DataStore()
        ret.loadFromGraphJSONS(jsons: jsons)
        return ret
    }
    
    func loadFromGraphJSONS( jsons: [GraphJSONLoader]) {
        var loci = Set<Locus>()
        var graphs = [Graph]()
        
        for json in jsons {
            graphs.append( json.asGraph )
            for i in 0 ..< json.loci.count {
                let locus = Locus( id: json.loci[i],
                                   coordinate: json.location[i],
                                   p: json.p[i],
                                   Ho: json.Ho[i],
                                   Hs: json.Hs[i],
                                   Ht: json.Ht[i] )
                if !loci.contains( locus ) {
                    loci.insert( locus )
                }
            }
        }
        self.loci = Array<Locus>(loci)
        self.graphs = graphs
    }
    
    
}
