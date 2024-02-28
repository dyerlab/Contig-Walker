//
//  Contig_WalkerApp.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2/28/24.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct Contig_WalkerApp: App {
    var body: some Scene {
        DocumentGroup(editing: .itemDocument, migrationPlan: Contig_WalkerMigrationPlan.self) {
            ContentView()
        }
    }
}

extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.text")
    }
}

struct Contig_WalkerMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        Contig_WalkerVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct Contig_WalkerVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        Node.self,
        Edge.self,
        Graph.self,
    ]
}
