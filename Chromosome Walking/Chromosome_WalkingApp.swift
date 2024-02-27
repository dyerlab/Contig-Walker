//
//  Chromosome_WalkingApp.swift
//  Chromosome Walking
//
//  Created by Rodney Dyer on 2024-02-27.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct Chromosome_WalkingApp: App {
    var body: some Scene {
        DocumentGroup(editing: .itemDocument, migrationPlan: Chromosome_WalkingMigrationPlan.self) {
            ContentView()
        }
    }
}

extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.item-document")
    }
}

struct Chromosome_WalkingMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        Chromosome_WalkingVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct Chromosome_WalkingVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        Item.self,
    ]
}
