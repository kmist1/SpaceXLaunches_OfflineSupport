//
//  MainView+Extension.swift
//  SpaceXLaunches_SwiftUI
//
//  Created by Krunal Mistry on 9/24/22.
//

import Foundation

/// Implement core data manager protocol
extension SpaceXLaunchesMainView: SpaceXCoreDataManagerProtocol {

    // Storing flights we get from API first time user launch app with network connection
    func addFlightsDataToCoreData(with flights: [Flights]) {
        for flight in flights {
            do {
                let newFlight = Flight(context: viewContext)
                newFlight.flightNumber = Int16(flight.flightNumber ?? 0)
                newFlight.missionName = flight.missionName
                try viewContext.save()
            } catch {
                print("Error saving data: \(error)")
            }
        }
    }

    // Delete local data if user wants to
    func deleteAllLocaleData() {
        do {
            let deletedData = viewContext.deletedObjects
            try viewContext.save()
            flights.removeAll()
            print("This data is being deleted: \(deletedData)")
        } catch {
            debugPrint("Error: \(error)")
        }
    }
}
