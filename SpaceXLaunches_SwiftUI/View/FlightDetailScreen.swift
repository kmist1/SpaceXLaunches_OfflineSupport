//
//  FlightDetailScreen.swift
//  SpaceXLaunch_SwiftUI
//
//  Created by Krunal Mistry on 3/12/22.
//

import SwiftUI

struct FlightDetailScreen: View {
    //MARK: Properties
    let flight: Flights

    //MARK: Flight Detail View
    var body: some View {
        VStack(spacing: 15) {
            AsyncImage(url: URL(string: flight.links?.missionPatch ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "photo.fill")
                    .resizable()
            }
            .frame(width: 200, height: 200)

            VStack(alignment: .leading, spacing: 10) {
                Text("Mission Name: " + (flight.missionName ?? "Not available"))
                Text("Rocket Name: " + (flight.rocket?.rocketName ?? "Not available"))
                Text("Details: " + (flight.details ?? "Not available"))
            }
            Spacer()
        }
        .padding()
    }
}

//MARK: Previews
struct FlightDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetailScreen(flight: Flights(isTentative: false))
    }
}
