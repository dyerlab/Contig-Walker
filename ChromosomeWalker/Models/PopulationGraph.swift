//
//  EdgeSet.swift
//  ChromosomeWalker
//
//  Created by Rodney Dyer on 2024-02-28.
//

import Foundation

class PopulationGraph: Codable {

    var nodes: [Node]
    var edges: [Edge]

}



extension PopulationGraph {
    
    static var getGraph: PopulationGraph? {
        
        let strSource =  """
{
 "nodes": [
    {"id":"Adygei","size":7.41630705579133}, 
    {"id":"Balochi","size":7.64812030029031},
    {"id":"BantuKenya","size":11.8312054787324},
    {"id":"BantuSouthAfrica","size":16.2118026677212},
    {"id":"Basque","size":6.70291669451451},
    {"id":"Bedouin","size":8.80211509179833},
    {"id":"BiakaPygmy","size":10.6630711795619},
    {"id":"Burusho","size":9.13891774058891},
    {"id":"Cambodian","size":6.47786967880827},
    {"id":"Colombian","size":7.10128099300636},
    {"id":"Daur","size":6.32360423211023},
    {"id":"Druze","size":8.43106332312998},
    {"id":"Kalash","size":7.22829794601833},
    {"id":"Lahu","size":7.56681260445022},
    {"id":"Mandenka","size":11.6482652120488},
    {"id":"Maya","size":5.10550390696308},
    {"id":"MbutiPygmy","size":15.1139827043693},
    {"id":"Melanesian","size":6.30116727136048},
    {"id":"Mongola","size":6.86320818998153},
    {"id":"Mozabite","size":7.57185589284675},
    {"id":"Palestinian","size":8.31178140012664},
    {"id":"Papuan","size":9.12343711835293},
    {"id":"Pima","size":5},
    {"id":"Russian","size":6.71155616507465},
    {"id":"San","size":17.3931596524482},
    {"id":"Uygur","size":6.93698922764988},
    {"id":"Yakut","size":6.886325841457},
    {"id":"Yi","size":7.75776861121264},
    {"id":"Yoruba","size":12.6717949148577}
    ],
"edges":[
    {"source":0,"target":7,"weight":2.73750389173014}, 
    {"source":0,"target":11,"weight":1.92956461712763},
    {"source":0,"target":13,"weight":3.4329128709125},
    {"source":0,"target":18,"weight":3.97229256054193},
    {"source":0,"target":20,"weight":2.04522625917473},
    {"source":0,"target":23,"weight":2.00461995601653},
    {"source":0,"target":25,"weight":2.36237337693847},
    {"source":0,"target":26,"weight":3.12099674106487},
    {"source":1,"target":7,"weight":2.75437163174436},
    {"source":1,"target":10,"weight":2.67544268014576},
    {"source":1,"target":11,"weight":1.94832226753326},
    {"source":1,"target":12,"weight":2.53733422609892},
    {"source":1,"target":25,"weight":2.25606812176437},
    {"source":2,"target":3,"weight":4.51422696146618},
    {"source":2,"target":6,"weight":4.46301943591892},
    {"source":2,"target":14,"weight":3.58291403945585},
    {"source":2,"target":21,"weight":5.82666611183282},
    {"source":2,"target":24,"weight":7.51232633146372},
    {"source":2,"target":28,"weight":3.81685688695163},
    {"source":3,"target":9,"weight":6.27607218046644},
    {"source":3,"target":14,"weight":3.83532638486293},
    {"source":3,"target":16,"weight":7.52178610581865},
    {"source":3,"target":28,"weight":3.69465946372675},
    {"source":4,"target":5,"weight":1.94580854551034},
    {"source":4,"target":11,"weight":2.06407194578314},
    {"source":4,"target":18,"weight":3.20054317846601},
    {"source":4,"target":19,"weight":2.31123418839238},
    {"source":4,"target":23,"weight":2.2016182199248},
    {"source":4,"target":27,"weight":2.50796295579811},
    {"source":5,"target":12,"weight":2.76338549793196},
    {"source":5,"target":13,"weight":3.55280239012281},
    {"source":5,"target":23,"weight":1.92151009399872},
    {"source":5,"target":25,"weight":2.95006197781999},
    {"source":6,"target":14,"weight":3.52890892233865},
    {"source":6,"target":16,"weight":6.12364083257054},
    {"source":6,"target":18,"weight":4.72607081157418},
    {"source":7,"target":12,"weight":2.7407124003416},
    {"source":7,"target":20,"weight":2.66311610391918},
    {"source":7,"target":21,"weight":4.56856767736669},
    {"source":7,"target":22,"weight":2.51930444625708},
    {"source":7,"target":23,"weight":2.41795168029333},
    {"source":8,"target":10,"weight":2.9788895702224},
    {"source":8,"target":13,"weight":3.70173525354078},
    {"source":8,"target":17,"weight":5.44329839603906},
    {"source":8,"target":18,"weight":2.01817808427628},
    {"source":8,"target":26,"weight":2.69521656833343},
    {"source":8,"target":27,"weight":2.44062464937805},
    {"source":9,"target":13,"weight":4.88266863426757},
    {"source":9,"target":15,"weight":3.69465871138403},
    {"source":9,"target":17,"weight":5.84463971402607},
    {"source":9,"target":26,"weight":3.99863325763494},
    {"source":10,"target":12,"weight":2.84424619622242},
    {"source":10,"target":13,"weight":3.78262843389081},
    {"source":10,"target":26,"weight":2.59801323857937},
    {"source":11,"target":12,"weight":2.19376596565784},
    {"source":11,"target":19,"weight":1.82807107250599},
    {"source":11,"target":20,"weight":2.04704651057886},
    {"source":11,"target":22,"weight":2.79908821149673},
    {"source":11,"target":23,"weight":1.84263355969835},
    {"source":11,"target":25,"weight":2.11025690970138},
    {"source":12,"target":22,"weight":2.60477267957669},
    {"source":13,"target":21,"weight":6.84977149068558},
    {"source":13,"target":24,"weight":8.64546096225926},
    {"source":13,"target":27,"weight":3.43382175464162},
    {"source":14,"target":24,"weight":6.58620922512184},
    {"source":14,"target":28,"weight":2.1483194106534},
    {"source":15,"target":19,"weight":2.05670059196415},
    {"source":15,"target":22,"weight":2.88665439322671},
    {"source":15,"target":26,"weight":2.8749545740432},
    {"source":16,"target":24,"weight":7.20023096937723},
    {"source":17,"target":21,"weight":4.23597156303657},
    {"source":17,"target":27,"weight":4.63038543860095},
    {"source":18,"target":20,"weight":2.98945645353089},
    {"source":18,"target":21,"weight":3.99963153106689}, 
    {"source":19,"target":22,"weight":2.41319642258315},
    {"source":19,"target":23,"weight":2.12336452794224},
    {"source":20,"target":27,"weight":2.57950158590581},
    {"source":22,"target":23,"weight":2.38968908355871},
    {"source":22,"target":25,"weight":2.37658016276265},
    {"source":23,"target":25,"weight":2.16785192655325},
    {"source":23,"target":26,"weight":3.47173292477783},
    {"source":23,"target":27,"weight":3.11431687646376},
    {"source":25,"target":27,"weight":2.44894759355784}
    ]
}
"""
        let jd = JSONDecoder()
        do {
            return try jd.decode( PopulationGraph.self, from: strSource.data(using: .utf8)! )
        } catch {
            print("Error decoding PopulationGraph \(error.localizedDescription)")
        }
        
        return nil 
    }
    
}
