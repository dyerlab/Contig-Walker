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
    var sharedModelContainer: ModelContainer = {
        return previewContainer
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
