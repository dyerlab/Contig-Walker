//
//  Contig_WalkerApp.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftUI

@main
struct Contig_WalkerApp: App {
    #if os(visionOS)
    @State var dataStore = DataStore.DefaultDataStore
    #else
    @State var dataStore = DataStore()
    #endif
    var body: some Scene {
        WindowGroup {
            MainWindowView(data: dataStore)
        }
        .commands {
            CommandGroup(replacing: .importExport, addition: {
                Button(action: {
                    print("Importing Menu")
                    NotificationCenter.default.post(name: .importData, object: nil)
                }, label: {
                    Text("Import")
                })
                .keyboardShortcut("I", modifiers: .command)
            })
        }
    }
}
