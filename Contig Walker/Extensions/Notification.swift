//
//  Notification.swift
//  Contig Walker
//
//  Created by Rodney Dyer on 2024-03-11.
//

import Foundation

/**
 Some custom notifications.
 */
extension Notification.Name {
    
    /// Toggles visual display of the labels in a graph view.
    static let toggleLabels = Notification.Name(rawValue: "onToggleLabels")
    
    /// Issued from menu command to import raw JSON values
    static let importData = Notification.Name(rawValue: "importJSON")
    
    /// Save datastore to file
    static let saveData = Notification.Name(rawValue: "saveData")
    
    /// Load datastore from file
    static let loadData = Notification.Name(rawValue: "loadData")
    
}
