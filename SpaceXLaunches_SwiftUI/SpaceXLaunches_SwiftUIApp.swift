//
//  SpaceXLaunches_SwiftUIApp.swift
//  SpaceXLaunches_SwiftUI
//
//  Created by Krunal Mistry on 3/12/22.
//

import SwiftUI
import CoreData

@main
struct SpaceXLaunches_SwiftUIApp: App {

    @StateObject private var manager: DataManager = DataManager()

    var body: some Scene {
        WindowGroup {
            SpaceXLaunchesMainView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.flightsContainer.viewContext)
        }
    }
}
