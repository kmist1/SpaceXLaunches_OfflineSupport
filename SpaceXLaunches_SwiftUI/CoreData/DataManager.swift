//
//  DataManager.swift
//  SpaceXLaunches_SwiftUI
//
//  Created by Krunal Mistry on 9/21/22.
//

import Foundation
import CoreData

/// Main data manager to handle the flights data
class DataManager: NSObject, ObservableObject {

    /// Add the Core Data container with the model name
    let flightsContainer: NSPersistentContainer = NSPersistentContainer(name: "SpaceXFlightModel")

    /// Default init method. Load the Core Data container
    override init() {
        super.init()
        flightsContainer.loadPersistentStores { _, _ in }
    }
}
