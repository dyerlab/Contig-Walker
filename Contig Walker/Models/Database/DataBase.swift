//
//  DataBase.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftData
import Foundation


let contigWalkerSchema = Schema( [ Node.self,
                                   Edge.self
                                 ])

@MainActor
public let previewContainer: ModelContainer = {
    let configuration = ModelConfiguration( schema: contigWalkerSchema,
                                            isStoredInMemoryOnly: true)
    
    do {
        
        let container = try ModelContainer( for: contigWalkerSchema,
                                            configurations: [configuration] )
        
        
        let context = container.mainContext
        
        /// Set up the default values.
        
        return container
        
    } catch {
        fatalError("Caught error in previewContainer: \(error.localizedDescription).")
    }
    
}()



