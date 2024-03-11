//
//  Contig_WalkerApp.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 3/1/24.
//

import SwiftUI

@main
struct Contig_WalkerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
                .fileImporter(isPresented: $importing,
                              allowedContentTypes: [.json],
                              onCompletion: <#T##(Result<URL, any Error>) -> Void##(Result<URL, any Error>) -> Void##(_ result: Result<URL, any Error>) -> Void#>)
            })
        }
    }
}
