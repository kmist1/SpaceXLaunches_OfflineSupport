//
//  SpaceXCoreDataProtocol.swift
//  SpaceXLaunches_SwiftUI
//
//  Created by Krunal Mistry on 9/24/22.
//

import Foundation

//MARK: Protocol Definations
/// This will define all methods required to manage data using coredata for SpaceX project
protocol SpaceXCoreDataManagerProtocol {
    func addFlightsDataToCoreData(with flights: [Flights])
    func deleteAllLocaleData()
}
