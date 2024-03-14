//
//  GraphJSONLoader.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/8/24.
//

import Foundation


class GraphJSONLoader: Codable {
    
    let nodes: [Node]
    let edges: [Edge]
    let loci: [String]
    let location: [Int]
    let p: [Double]
    let Ho: [Double]
    let Hs: [Double]
    let Ht: [Double]
    
    
    var asGraph: Graph {
        return Graph(nodes: nodes, edges: edges, loci: asLoci.compactMap( {$0.id} ) )
    }
    
    
    var asLoci: [Locus] {
        var theLoci = [Locus]()
        for i in 0 ..< loci.count {
            let locus = Locus(id: loci[i],
                              coordinate: UInt(location[i]),
                              p: p[i],
                              Ho: Ho[i],
                              Hs: Hs[i],
                              Ht: Ht[i] )
            theLoci.append( locus )
        }
        
        return theLoci
    }
    
    enum CodingKeys: String, CodingKey {
        case nodes = "nodes"
        case links = "links"
        case loci = "loci"
        case location = "location"
        case p = "p"
        case Ho = "Ho"
        case Hs = "Hs"
        case Ht = "Ht"
    }
    
    init(nodes: [Node]=[], edges: [Edge]=[], loci: [String]=[], location: [Int]=[], p: [Double]=[], Ho: [Double]=[], Hs: [Double]=[],Ht: [Double]=[]) {
        self.nodes = nodes
        self.edges = edges
        self.loci = loci
        self.location = location
        self.p = p
        self.Ho = Ho
        self.Hs = Hs
        self.Ht = Ht
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        nodes = try container.decode( [Node].self, forKey: .nodes )
        edges = try container.decode( [Edge].self, forKey: .links )
        loci = try container.decode( [String].self, forKey: .loci )
        location = try container.decode( [Int].self, forKey: .location )
        p = try container.decode( [Double].self, forKey: .p )
        Ho = try container.decode( [Double].self, forKey: .Ho )
        Hs = try container.decode( [Double].self, forKey: .Hs )
        Ht = try container.decode( [Double].self, forKey: .Ht )
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self )
        try container.encode( nodes, forKey: .nodes )
        try container.encode( edges, forKey: .links )
        try container.encode( loci, forKey: .loci )
        try container.encode( location, forKey: .location)
        try container.encode( p, forKey: .p )
        try container.encode( Ho, forKey: .Ho )
        try container.encode( Hs, forKey: .Hs )
        try container.encode( Ht, forKey: .Ht )
    }
    
    
}


extension GraphJSONLoader: CustomStringConvertible {
    var description: String {
        var ret = "Graph: \(nodes.count) nodes, \(edges.count) edges, \(loci.count) loci."
        ret += "Node:\n"
        for node in nodes {
            ret += "  \(node)\n"
        }
        ret += "Edges:\n"
        for edge in edges {
            ret += "  \(edge)\n"
        }
        return ret
    }
}


extension GraphJSONLoader {
    
    
    static func loadFromURLs( urls: [URL]) -> [GraphJSONLoader] {
        var ret = [GraphJSONLoader]()
        let jd = JSONDecoder()
        
        for url in urls {
            do {
                if url.startAccessingSecurityScopedResource() {
                    let rawJSON = try String(contentsOf: url)
                    let graph = try jd.decode( GraphJSONLoader.self, from: rawJSON.data(using: .utf8)! )
                    ret.append( graph )
                    url.stopAccessingSecurityScopedResource()
                }
                
            } catch {
                print("Error in GraphJSONLoader::loadFromURLs \(error)")
            }
        }
        return ret
    }
    
    static var DefaultGraphs: [GraphJSONLoader] {
        var ret = [GraphJSONLoader]()
        let jd = JSONDecoder()
        
        for i in 1 ... 100 {
            let filename = String("graph_chr2_40bp_\(i)")
            if let path = Bundle.main.path(forResource: filename, ofType: "json") {
                do {
                    let rawJSON = try String(contentsOfFile: path)
                    let graph = try jd.decode(GraphJSONLoader.self, from: rawJSON.data(using: .utf8)! )
                    ret.append( graph )
                } catch {
                    print("Failing \(path) with error \(error)")
                }
            } else {
                print("Could not find path to \(filename)")
            }
        }
        return ret
    }
    
    static var DefaultGraph: GraphJSONLoader {
        let rawJSON = GraphJSONLoader.DefaultJSON
        let jd = JSONDecoder()
        do {
            
            let graph = try jd.decode( GraphJSONLoader.self, from: rawJSON.data(using: .utf8)!)
            print("\(graph)")
            return graph
        } catch {
            fatalError("Could not make JSON graph, \(error)")
        }
    }
    
    
    static var DefaultJSON: String {
        let rawJSON: String = """
{
  "nodes": [
    {
      "size": 7.4163,
      "id": "Adygei",
      "longitude": 39,
      "latitude": 44,
      "group": "All"
    },
    {
      "size": 7.6481,
      "id": "Balochi",
      "longitude": 66.5,
      "latitude": 30.4987,
      "group": "All"
    },
    {
      "size": 11.8312,
      "id": "BantuKenya",
      "longitude": 37,
      "latitude": -3,
      "group": "All"
    },
    {
      "size": 16.2118,
      "id": "BantuSouthAfrica",
      "longitude": 24.25,
      "latitude": -25.5693,
      "group": "All"
    },
    {
      "size": 6.7029,
      "id": "Basque",
      "longitude": 0,
      "latitude": 43,
      "group": "All"
    },
    {
      "size": 8.8021,
      "id": "Bedouin",
      "longitude": 35,
      "latitude": 31,
      "group": "All"
    },
    {
      "size": 10.6631,
      "id": "BiakaPygmy",
      "longitude": 17,
      "latitude": 4,
      "group": "All"
    },
    {
      "size": 9.1389,
      "id": "Burusho",
      "longitude": 74,
      "latitude": 36.4984,
      "group": "All"
    },
    {
      "size": 6.4779,
      "id": "Cambodian",
      "longitude": 105,
      "latitude": 12,
      "group": "All"
    },
    {
      "size": 7.1013,
      "id": "Colombian",
      "longitude": -68,
      "latitude": 3,
      "group": "All"
    },
    {
      "size": 6.3236,
      "id": "Daur",
      "longitude": 124,
      "latitude": 48.4975,
      "group": "All"
    },
    {
      "size": 8.4311,
      "id": "Druze",
      "longitude": 35,
      "latitude": 32,
      "group": "All"
    },
    {
      "size": 7.2283,
      "id": "Kalash",
      "longitude": 71.5,
      "latitude": 35.9937,
      "group": "All"
    },
    {
      "size": 7.5668,
      "id": "Lahu",
      "longitude": 100,
      "latitude": 22,
      "group": "All"
    },
    {
      "size": 11.6483,
      "id": "Mandenka",
      "longitude": -12,
      "latitude": 12,
      "group": "All"
    },
    {
      "size": 5.1055,
      "id": "Maya",
      "longitude": -91,
      "latitude": 19,
      "group": "All"
    },
    {
      "size": 15.114,
      "id": "MbutiPygmy",
      "longitude": 29,
      "latitude": 1,
      "group": "All"
    },
    {
      "size": 6.3012,
      "id": "Melanesian",
      "longitude": 155,
      "latitude": -6,
      "group": "All"
    },
    {
      "size": 6.8632,
      "id": "Mongola",
      "longitude": 111,
      "latitude": 45,
      "group": "All"
    },
    {
      "size": 7.5719,
      "id": "Mozabite",
      "longitude": 3,
      "latitude": 32,
      "group": "All"
    },
    {
      "size": 8.3118,
      "id": "Palestinian",
      "longitude": 35,
      "latitude": 32,
      "group": "All"
    },
    {
      "size": 9.1234,
      "id": "Papuan",
      "longitude": 143,
      "latitude": -4,
      "group": "All"
    },
    {
      "size": 5,
      "id": "Pima",
      "longitude": -108,
      "latitude": 29,
      "group": "All"
    },
    {
      "size": 6.7116,
      "id": "Russian",
      "longitude": 40,
      "latitude": 61,
      "group": "All"
    },
    {
      "size": 17.3932,
      "id": "San",
      "longitude": 20,
      "latitude": -21,
      "group": "All"
    },
    {
      "size": 6.937,
      "id": "Uygur",
      "longitude": 81,
      "latitude": 44,
      "group": "All"
    },
    {
      "size": 6.8863,
      "id": "Yakut",
      "longitude": 129.5,
      "latitude": 62.9829,
      "group": "All"
    },
    {
      "size": 7.7578,
      "id": "Yi",
      "longitude": 103,
      "latitude": 28,
      "group": "All"
    },
    {
      "size": 12.6718,
      "id": "Yoruba",
      "longitude": 5,
      "latitude": 7.9951,
      "group": "All"
    }
  ],
  "links": [
    {
      "source": "Adygei",
      "target": "Burusho",
      "weight": 2.7375
    },
    {
      "source": "Adygei",
      "target": "Druze",
      "weight": 1.9296
    },
    {
      "source": "Adygei",
      "target": "Lahu",
      "weight": 3.4329
    },
    {
      "source": "Adygei",
      "target": "Mongola",
      "weight": 3.9723
    },
    {
      "source": "Adygei",
      "target": "Palestinian",
      "weight": 2.0452
    },
    {
      "source": "Adygei",
      "target": "Russian",
      "weight": 2.0046
    },
    {
      "source": "Adygei",
      "target": "Uygur",
      "weight": 2.3624
    },
    {
      "source": "Adygei",
      "target": "Yakut",
      "weight": 3.121
    },
    {
      "source": "Balochi",
      "target": "Burusho",
      "weight": 2.7544
    },
    {
      "source": "Balochi",
      "target": "Daur",
      "weight": 2.6754
    },
    {
      "source": "Balochi",
      "target": "Druze",
      "weight": 1.9483
    },
    {
      "source": "Balochi",
      "target": "Kalash",
      "weight": 2.5373
    },
    {
      "source": "Balochi",
      "target": "Uygur",
      "weight": 2.2561
    },
    {
      "source": "BantuKenya",
      "target": "BantuSouthAfrica",
      "weight": 4.5142
    },
    {
      "source": "BantuKenya",
      "target": "BiakaPygmy",
      "weight": 4.463
    },
    {
      "source": "BantuKenya",
      "target": "Mandenka",
      "weight": 3.5829
    },
    {
      "source": "BantuKenya",
      "target": "Papuan",
      "weight": 5.8267
    },
    {
      "source": "BantuKenya",
      "target": "San",
      "weight": 7.5123
    },
    {
      "source": "BantuKenya",
      "target": "Yoruba",
      "weight": 3.8169
    },
    {
      "source": "BantuSouthAfrica",
      "target": "Colombian",
      "weight": 6.2761
    },
    {
      "source": "BantuSouthAfrica",
      "target": "Mandenka",
      "weight": 3.8353
    },
    {
      "source": "BantuSouthAfrica",
      "target": "MbutiPygmy",
      "weight": 7.5218
    },
    {
      "source": "BantuSouthAfrica",
      "target": "Yoruba",
      "weight": 3.6947
    },
    {
      "source": "Basque",
      "target": "Bedouin",
      "weight": 1.9458
    },
    {
      "source": "Basque",
      "target": "Druze",
      "weight": 2.0641
    },
    {
      "source": "Basque",
      "target": "Mongola",
      "weight": 3.2005
    },
    {
      "source": "Basque",
      "target": "Mozabite",
      "weight": 2.3112
    },
    {
      "source": "Basque",
      "target": "Russian",
      "weight": 2.2016
    },
    {
      "source": "Basque",
      "target": "Yi",
      "weight": 2.508
    },
    {
      "source": "Bedouin",
      "target": "Kalash",
      "weight": 2.7634
    },
    {
      "source": "Bedouin",
      "target": "Lahu",
      "weight": 3.5528
    },
    {
      "source": "Bedouin",
      "target": "Russian",
      "weight": 1.9215
    },
    {
      "source": "Bedouin",
      "target": "Uygur",
      "weight": 2.9501
    },
    {
      "source": "BiakaPygmy",
      "target": "Mandenka",
      "weight": 3.5289
    },
    {
      "source": "BiakaPygmy",
      "target": "MbutiPygmy",
      "weight": 6.1236
    },
    {
      "source": "BiakaPygmy",
      "target": "Mongola",
      "weight": 4.7261
    },
    {
      "source": "Burusho",
      "target": "Kalash",
      "weight": 2.7407
    },
    {
      "source": "Burusho",
      "target": "Palestinian",
      "weight": 2.6631
    },
    {
      "source": "Burusho",
      "target": "Papuan",
      "weight": 4.5686
    },
    {
      "source": "Burusho",
      "target": "Pima",
      "weight": 2.5193
    },
    {
      "source": "Burusho",
      "target": "Russian",
      "weight": 2.418
    },
    {
      "source": "Cambodian",
      "target": "Daur",
      "weight": 2.9789
    },
    {
      "source": "Cambodian",
      "target": "Lahu",
      "weight": 3.7017
    },
    {
      "source": "Cambodian",
      "target": "Melanesian",
      "weight": 5.4433
    },
    {
      "source": "Cambodian",
      "target": "Mongola",
      "weight": 2.0182
    },
    {
      "source": "Cambodian",
      "target": "Yakut",
      "weight": 2.6952
    },
    {
      "source": "Cambodian",
      "target": "Yi",
      "weight": 2.4406
    },
    {
      "source": "Colombian",
      "target": "Lahu",
      "weight": 4.8827
    },
    {
      "source": "Colombian",
      "target": "Maya",
      "weight": 3.6947
    },
    {
      "source": "Colombian",
      "target": "Melanesian",
      "weight": 5.8446
    },
    {
      "source": "Colombian",
      "target": "Yakut",
      "weight": 3.9986
    },
    {
      "source": "Daur",
      "target": "Kalash",
      "weight": 2.8442
    },
    {
      "source": "Daur",
      "target": "Lahu",
      "weight": 3.7826
    },
    {
      "source": "Daur",
      "target": "Yakut",
      "weight": 2.598
    },
    {
      "source": "Druze",
      "target": "Kalash",
      "weight": 2.1938
    },
    {
      "source": "Druze",
      "target": "Mozabite",
      "weight": 1.8281
    },
    {
      "source": "Druze",
      "target": "Palestinian",
      "weight": 2.047
    },
    {
      "source": "Druze",
      "target": "Pima",
      "weight": 2.7991
    },
    {
      "source": "Druze",
      "target": "Russian",
      "weight": 1.8426
    },
    {
      "source": "Druze",
      "target": "Uygur",
      "weight": 2.1103
    },
    {
      "source": "Kalash",
      "target": "Pima",
      "weight": 2.6048
    },
    {
      "source": "Lahu",
      "target": "Papuan",
      "weight": 6.8498
    },
    {
      "source": "Lahu",
      "target": "San",
      "weight": 8.6455
    },
    {
      "source": "Lahu",
      "target": "Yi",
      "weight": 3.4338
    },
    {
      "source": "Mandenka",
      "target": "San",
      "weight": 6.5862
    },
    {
      "source": "Mandenka",
      "target": "Yoruba",
      "weight": 2.1483
    },
    {
      "source": "Maya",
      "target": "Mozabite",
      "weight": 2.0567
    },
    {
      "source": "Maya",
      "target": "Pima",
      "weight": 2.8867
    },
    {
      "source": "Maya",
      "target": "Yakut",
      "weight": 2.875
    },
    {
      "source": "MbutiPygmy",
      "target": "San",
      "weight": 7.2002
    },
    {
      "source": "Melanesian",
      "target": "Papuan",
      "weight": 4.236
    },
    {
      "source": "Melanesian",
      "target": "Yi",
      "weight": 4.6304
    },
    {
      "source": "Mongola",
      "target": "Palestinian",
      "weight": 2.9895
    },
    {
      "source": "Mongola",
      "target": "Papuan",
      "weight": 3.9996
    },
    {
      "source": "Mozabite",
      "target": "Pima",
      "weight": 2.4132
    },
    {
      "source": "Mozabite",
      "target": "Russian",
      "weight": 2.1234
    },
    {
      "source": "Palestinian",
      "target": "Yi",
      "weight": 2.5795
    },
    {
      "source": "Pima",
      "target": "Russian",
      "weight": 2.3897
    },
    {
      "source": "Pima",
      "target": "Uygur",
      "weight": 2.3766
    },
    {
      "source": "Russian",
      "target": "Uygur",
      "weight": 2.1679
    },
    {
      "source": "Russian",
      "target": "Yakut",
      "weight": 3.4717
    },
    {
      "source": "Russian",
      "target": "Yi",
      "weight": 3.1143
    },
    {
      "source": "Uygur",
      "target": "Yi",
      "weight": 2.4489
    }
  ],
  "loci": ["rs4637157", "rs11900053", "rs11542478", "rs11897072", "rs6713375", "rs300789", "rs7588043", "rs6755432", "rs300780", "rs300773", "rs10519439", "rs435733", "rs437409", "rs409954", "rs409572", "rs13033859", "rs440617", "rs415660", "rs384526", "rs385909", "rs434818", "rs385272", "rs2952790", "rs2290911", "rs3791221", "rs6742278", "rs10205435", "rs1461028", "rs10181051", "rs4455191", "rs7596678", "rs12714402", "rs6548221", "rs6742672", "rs6717613", "rs4643574", "rs6719944", "rs6548226", "rs6548227", "rs12472764"],
  "location": [19443, 26787, 28938, 37808, 75793, 79910, 94979, 96692, 100819, 105035, 108913, 111222, 132137, 139546, 143302, 174390, 179818, 179972, 183882, 189678, 190477, 196704, 202106, 214919, 216933, 216999, 220442, 228975, 232800, 246278, 252553, 262926, 285255, 291784, 299480, 305215, 310574, 333588, 335703, 338470],
  "p": [0.2052, 0.2571, 0.1424, 0.0377, 0.0536, 0.124, 0.2563, 0.2538, 0.4338, 0.2035, 0.2479, 0.1692, 0.2789, 0.1558, 0.2211, 0.4606, 0.325, 0.2328, 0.4765, 0.2789, 0.0905, 0.2881, 0.2923, 0.2211, 0.2563, 0.0637, 0.4883, 0.3074, 0.3291, 0.263, 0.3928, 0.4213, 0.2429, 0.4012, 0.469, 0.2052, 0.258, 0.4414, 0.139, 0.3501],
  "Ho": [0.2864, 0.2998, 0.2111, 0.0653, 0.0871, 0.1843, 0.3518, 0.3467, 0.4556, 0.2998, 0.3283, 0.2546, 0.3467, 0.2479, 0.3015, 0.3953, 0.2881, 0.3082, 0.3601, 0.3132, 0.1642, 0.3082, 0.4204, 0.3283, 0.3618, 0.1072, 0.4037, 0.3802, 0.397, 0.3149, 0.4874, 0.4874, 0.3451, 0.4204, 0.4322, 0.3233, 0.3719, 0.4338, 0.2211, 0.3953],
  "Hs": [0.279, 0.2844, 0.2601, 0.0578, 0.0942, 0.1714, 0.3585, 0.3513, 0.4557, 0.3283, 0.322, 0.2566, 0.3866, 0.223, 0.3203, 0.3924, 0.2668, 0.2947, 0.3727, 0.2833, 0.1458, 0.2787, 0.3717, 0.3569, 0.3892, 0.0847, 0.3811, 0.3805, 0.4132, 0.3209, 0.4454, 0.4578, 0.317, 0.443, 0.4438, 0.3158, 0.3546, 0.4247, 0.2243, 0.3934],
  "Ht": [0.3172, 0.3901, 0.2913, 0.0595, 0.1087, 0.202, 0.3893, 0.3853, 0.4826, 0.3501, 0.3555, 0.2745, 0.415, 0.2302, 0.3506, 0.4989, 0.4287, 0.3477, 0.4975, 0.396, 0.1562, 0.406, 0.3956, 0.3708, 0.4111, 0.0863, 0.5004, 0.418, 0.4386, 0.3778, 0.4653, 0.4825, 0.3387, 0.4836, 0.4987, 0.3386, 0.3898, 0.4995, 0.2386, 0.4218]
}
"""
        return rawJSON
    }
    
    
}
