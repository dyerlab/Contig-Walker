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
    let He: [Double]
    
    
    var asGraph: Graph {
        return Graph(nodes: nodes, edges: edges, loci: asLoci.compactMap( {$0.id}))
    }
    
    
    var asLoci: [Locus] {
        var theLoci = [Locus]()
        for i in 0 ..< loci.count {
            let locus = Locus(id: loci[i],
                              location: location[i],
                              p: p[i],
                              Ho: Ho[i],
                              He: He[i] )
            theLoci.append( locus )
        }
        
        return theLoci
    }
    
    enum CodingKeys: String, CodingKey {
        case nodes = "nodes"
        case edges = "edges"
        case loci = "loci"
        case location = "location"
        case p = "p"
        case Ho = "Ho"
        case He = "He"
    }
    
    init(nodes: [Node]=[], edges: [Edge]=[], loci: [String]=[], location: [Int]=[], p: [Double]=[], Ho: [Double]=[], He: [Double]=[]) {
        self.nodes = nodes
        self.edges = edges
        self.loci = loci
        self.location = location
        self.p = p
        self.Ho = Ho
        self.He = He
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        nodes = try container.decode( [Node].self, forKey: .nodes )
        edges = try container.decode( [Edge].self, forKey: .edges )
        loci = try container.decode( [String].self, forKey: .loci )
        location = try container.decode( [Int].self, forKey: .location )
        p = try container.decode( [Double].self, forKey: .p )
        Ho = try container.decode( [Double].self, forKey: .Ho )
        He = try container.decode( [Double].self, forKey: .He )
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self )
        try container.encode( nodes, forKey: .nodes )
        try container.encode( edges, forKey: .edges )
        try container.encode( loci, forKey: .loci )
        try container.encode( location, forKey: .location)
        try container.encode( p, forKey: .p )
        try container.encode( Ho, forKey: .Ho )
        try container.encode( He, forKey: .He )
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
    
    static var DefaultGraphs: [GraphJSONLoader] {
        var ret = [GraphJSONLoader]()
        let jd = JSONDecoder()
        
        for i in 1 ... 50 {
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
    "nodes":[
        {"size": 9.3228,"id": "Adygei","longitude": 39,"latitude": 44,"group": "All"},
        {"size": 10.8555,"id": "Balochi","longitude": 66.5,"latitude": 30.4987,"group": "All"},
        {"size": 13.3148,"id": "BantuKenya","longitude": 37,"latitude": -3,"group": "All"},
        {"size": 16.067,"id": "BantuSouthAfrica","longitude": 24.25,"latitude": -25.5693,"group": "All"},
        {"size": 10.5248,"id": "Basque","longitude": 0,"latitude": 43,"group": "All"},
        {"size": 9.3466,"id": "Bedouin","longitude": 35,"latitude": 31,"group": "All"},
        {"size": 12.7948,"id": "BiakaPygmy","longitude": 17,"latitude": 4,"group": "All"},
        {"size": 10.2652,"id": "Burusho","longitude": 74,"latitude": 36.4984,"group": "All"},
        {"size": 9.2732,"id": "Cambodian","longitude": 105,"latitude": 12,"group": "All"},
        {"size": 5,"id": "Colombian","longitude": -68,"latitude": 3,"group": "All"},
        {"size": 5.5496,"id": "Daur","longitude": 124,"latitude": 48.4975,"group": "All"},
        {"size": 8.5541,"id": "Druze","longitude": 35,"latitude": 32,"group": "All"},
        {"size": 5.3933,"id": "Kalash","longitude": 71.5,"latitude": 35.9937,"group": "All"},
        {"size": 7.9792,"id": "Lahu","longitude": 100,"latitude": 22,"group": "All"},
        {"size": 12.4619,"id": "Mandenka","longitude": -12,"latitude": 12,"group": "All"},
        {"size": 6.4403,"id": "Maya","longitude": -91,"latitude": 19,"group": "All"},
        {"size": 12.8053,"id": "MbutiPygmy","longitude": 29,"latitude": 1,"group": "All"},
        {"size": 5.8726,"id": "Melanesian","longitude": 155,"latitude": -6,"group": "All"},
        {"size": 5.6915,"id": "Mongola","longitude": 111,"latitude": 45,"group": "All"},
        {"size": 10.141,"id": "Mozabite","longitude": 3,"latitude": 32,"group": "All"},
        {"size": 10.1315,"id": "Palestinian","longitude": 35,"latitude": 32,"group": "All"},
        {"size": 5.4853,"id": "Papuan","longitude": 143,"latitude": -4,"group": "All"},
        {"size": 6.8006,"id": "Pima","longitude": -108,"latitude": 29,"group": "All"},
        {"size": 7.7305,"id": "Russian","longitude": 40,"latitude": 61,"group": "All"},
        {"size": 10.4458,"id": "San","longitude": 20,"latitude": -21,"group": "All"},
        {"size": 5.5877,"id": "Uygur","longitude": 81,"latitude": 44,"group": "All"},
        {"size": 8.3863,"id": "Yakut","longitude": 129.5,"latitude": 62.9829,"group": "All"},
        {"size": 8.8089,"id": "Yi","longitude": 103,"latitude": 28,"group": "All"},
        {"size": 11.1401,"id": "Yoruba","longitude": 5,"latitude": 7.9951,"group": "All"}
    ],
    "edges":[
        {"source": "Adygei","target": "Balochi", "weight": 2.4355},
        {"source": "Adygei","target": "Burusho", "weight": 3.1759},
        {"source": "Adygei","target": "Palestinian", "weight": 1.964},
        {"source": "Balochi","target": "Burusho", "weight": 2.5206},
        {"source": "Balochi","target": "Druze", "weight": 2.115},
        {"source": "Balochi","target": "Uygur", "weight": 2.3598},
        {"source": "Balochi","target": "Yi", "weight": 3.5495},
        {"source": "BantuKenya","target": "BantuSouthAfrica", "weight": 3.5656},
        {"source": "BantuKenya","target": "Bedouin", "weight": 3.7653},
        {"source": "BantuKenya","target": "BiakaPygmy", "weight": 4.1534},
        {"source": "BantuKenya","target": "Pima", "weight": 4.9013},
        {"source": "BantuKenya","target": "Yoruba", "weight": 2.9284},
        {"source": "BantuSouthAfrica","target": "Mandenka", "weight": 3.7185},
        {"source": "BantuSouthAfrica","target": "MbutiPygmy", "weight": 5.3965},
        {"source": "BantuSouthAfrica","target": "Melanesian", "weight": 5.6255},
        {"source": "BantuSouthAfrica","target": "San", "weight": 6.7631},
        {"source": "BantuSouthAfrica","target": "Yoruba", "weight": 3.1801},
        {"source": "Basque","target": "Druze", "weight": 2.2842},
        {"source": "Basque","target": "MbutiPygmy", "weight": 7.179},
        {"source": "Basque","target": "Melanesian", "weight": 3.0649},
        {"source": "Basque","target": "Mozabite", "weight": 2.864},
        {"source": "Basque","target": "Pima", "weight": 3.8908},
        {"source": "Basque","target": "Russian", "weight": 2.6733},
        {"source": "Basque","target": "Yi", "weight": 4.6824},
        {"source": "Bedouin","target": "Mozabite", "weight": 2.0313},
        {"source": "Bedouin","target": "Palestinian", "weight": 1.7038},
        {"source": "Bedouin","target": "Russian", "weight": 2.4025},
        {"source": "BiakaPygmy","target": "Mandenka", "weight": 4.653},
        {"source": "BiakaPygmy","target": "MbutiPygmy", "weight": 4.8587},
        {"source": "BiakaPygmy","target": "San", "weight": 6.6517},
        {"source": "BiakaPygmy","target": "Yoruba", "weight": 3.7082},
        {"source": "Burusho","target": "Mozabite", "weight": 4.0147},
        {"source": "Burusho","target": "Palestinian", "weight": 3.0749},
        {"source": "Burusho","target": "Russian", "weight": 3.2383},
        {"source": "Cambodian","target": "Daur", "weight": 3.1378},
        {"source": "Cambodian","target": "Lahu", "weight": 3.3959},
        {"source": "Cambodian","target": "Mandenka", "weight": 4.631},
        {"source": "Cambodian","target": "Yi", "weight": 2.7503},
        {"source": "Colombian","target": "Lahu", "weight": 3.7309},
        {"source": "Colombian","target": "Maya", "weight": 3.3447},
        {"source": "Colombian","target": "Papuan", "weight": 4.7448},
        {"source": "Colombian","target": "Pima", "weight": 3.2337},
        {"source": "Colombian","target": "San", "weight": 9.6959},
        {"source": "Daur","target": "Lahu", "weight": 3.3585},
        {"source": "Daur","target": "Mongola", "weight": 2.277},
        {"source": "Daur","target": "Yakut", "weight": 1.7967},
        {"source": "Druze","target": "Mozabite", "weight": 2.1673},
        {"source": "Druze","target": "Russian", "weight": 2.0912},
        {"source": "Druze","target": "Uygur", "weight": 1.9455},
        {"source": "Kalash","target": "Lahu", "weight": 4.5779},
        {"source": "Kalash","target": "Papuan", "weight": 3.4262},
        {"source": "Kalash","target": "Russian", "weight": 2.1756},
        {"source": "Lahu","target": "Pima", "weight": 3.615},
        {"source": "Lahu","target": "Yi", "weight": 3.2197},
        {"source": "Mandenka","target": "Mozabite", "weight": 4.2285},
        {"source": "Mandenka","target": "Yoruba", "weight": 3.1222},
        {"source": "Maya","target": "Pima", "weight": 3.2395},
        {"source": "Maya","target": "Yi", "weight": 4.2564},
        {"source": "MbutiPygmy","target": "San", "weight": 7.7273},
        {"source": "MbutiPygmy","target": "Yoruba", "weight": 4.4595},
        {"source": "Melanesian","target": "Papuan", "weight": 2.9801},
        {"source": "Melanesian","target": "Uygur", "weight": 2.7177},
        {"source": "Melanesian","target": "Yakut", "weight": 3.1852},
        {"source": "Mongola","target": "Yakut", "weight": 2.2509},
        {"source": "Mongola","target": "Yi", "weight": 2.6987},
        {"source": "Mozabite","target": "Palestinian", "weight": 2.2361},
        {"source": "Papuan","target": "San", "weight": 9.5358},
        {"source": "Russian","target": "Yi", "weight": 4.1283},
        {"source": "Uygur","target": "Yakut", "weight": 2.5936}
        ],
    "loci":["rs1439820","rs735671","rs1866608","rs7569982","rs13427718","rs10495510","rs6750212","rs6753305","rs1371473","rs1821990","rs13427627","rs1595752","rs934993","rs13002818","rs6747617","rs12621974","rs4606942","rs1371477","rs1439826","rs10495513","rs1439829","rs6760035","rs6542644","rs2580871","rs1344999","rs4355130","rs4144195","rs6712088","rs9989821","rs12615696","rs7602355","rs722148","rs721087","rs2966429","rs13016249","rs12463956","rs12464103","rs6422705","rs7371437","rs12619603"],
    "location":[4350675,4353606,4358554,4362933,4368315,4368613,4368666,4368804,4371513,4375491,4379189,4379202,4379453,4382573,4383294,4386935,4399063,4403289,4406036,4410308,4411130,4416490,4423699,4430085,4442062,4445447,4450558,4450781,4452201,4455838,4456747,4457407,4457834,4460571,4467148,4467766,4468149,4469322,4470658,4475302],
    "p":[0.428,0.2161,0.0603,0.2085,0.4372,0.1884,0.093,0.0771,0.1834,0.366,0.1139,0.2772,0.3484,0.2337,0.2504,0.4246,0.0302,0.4925,0.1776,0.3333,0.3769,0.0972,0.4003,0.1348,0.0905,0.3551,0.072,0.3183,0.4129,0.3936,0.2312,0.3911,0.0444,0.2085,0.428,0.1616,0.4095,0.1851,0.469,0.2094],
    "Ho":[0.4606,0.3283,0.0972,0.273,0.4255,0.2663,0.1591,0.1273,0.2362,0.3903,0.191,0.3434,0.3953,0.3065,0.3601,0.4338,0.0503,0.3585,0.2747,0.3283,0.3786,0.1474,0.4389,0.1859,0.1508,0.4087,0.1273,0.325,0.4003,0.4523,0.2814,0.4372,0.0787,0.3132,0.4037,0.2362,0.4137,0.2429,0.3886,0.2781],
    "He":[0.4896,0.3388,0.1133,0.3301,0.4921,0.3059,0.1686,0.1422,0.2996,0.4641,0.2019,0.4007,0.454,0.3581,0.3754,0.4886,0.0585,0.4999,0.2921,0.4444,0.4697,0.1754,0.4801,0.2333,0.1645,0.458,0.1337,0.4339,0.4848,0.4774,0.3554,0.4763,0.0848,0.3301,0.4896,0.271,0.4836,0.3017,0.4981,0.3311]
}
"""
        return rawJSON
    }
    
    
}