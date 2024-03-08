//
//  Contig_WalkerApp.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftUI
import SwiftData

@main
struct Contig_WalkerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(graphDataContainer)
    }
}
