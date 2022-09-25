//
//  Flights.swift
//  SpaceXLaunch_SwiftUI
//
//  Created by Krunal Mistry on 3/12/22.
//

import Foundation

struct Flights: Codable, Hashable {
    static func == (lhs: Flights, rhs: Flights) -> Bool {
        lhs.missionName == rhs.missionName
    }

    var flightNumber: Int?
    var missionName: String?
    var missionId:[String]?
    var upcoming: Bool?
    var launchYear: String?
    var launchDateUnix: Double?
    var launchDateUtc: String?
    var launchDateLocal: String?
    var isTentative: Bool
    var tentativeMaxPrecision: String?
    var tbd: Bool?
    var rocket: Rocket?
    var launchSite: LaunchSite?
    var links: Links?
    var launchSuccess: Bool?
    var details: String?
}

struct Rocket: Codable, Hashable {
    var rocketName: String
}

struct LaunchSite: Codable, Hashable {
    var siteName: String?
}

struct Links: Codable, Hashable {
    var missionPatch: String?
}
