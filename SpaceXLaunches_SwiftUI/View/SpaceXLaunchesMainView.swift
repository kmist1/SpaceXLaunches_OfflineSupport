//
//  ContentView.swift
//  SpaceXLaunches_SwiftUI
//
//  Created by Krunal Mistry on 3/12/22.
//

import SwiftUI

struct SpaceXLaunchesMainView: View {

    //MARK: Properties
    @ObservedObject var flightVM = FlightViewModel()
    @State var flights: [Flights] = []
    @State var showDetailViewScreen: Bool = false
    @State var detailViewScreenDestination: FlightDetailScreen?

    //MARK: CoreData properties
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) private var flightsData: FetchedResults<Flight>

    //MARK: Content View
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    NavigationLink(destination: detailViewScreenDestination, isActive: $showDetailViewScreen) {
                        EmptyView()
                            .hidden()
                    }

                    if flights.isEmpty {
                        VStack {
                            RotatingCircleView()
                        }
                    } else {
                        ForEach(flights, id: \.self) { flight in

                            HStack(alignment: .top, spacing: 0) {
                                AsyncImage(url: URL(string: flight.links?.missionPatch ?? ""), content: { image in
                                    image
                                        .resizable()
                                }, placeholder: {
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                })
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5))

                                VStack(alignment: .leading, spacing: 10) {
                                    if let flightLaunchStatus = flight.launchSuccess {
                                        Text(flightLaunchStatus ? "SUCCESS" : "FAILURE")
                                            .foregroundColor(flightLaunchStatus ? Color.green : Color.red)
                                    }
                                    Text("Mission Name:" + (flight.missionName ?? "Not available"))
                                        .multilineTextAlignment(.leading)
                                    Text("Flight No.:" + String(flight.flightNumber ?? 0))
                                    Text("Launch Site: " + (flight.launchSite?.siteName ?? "Not available"))
                                    Text("Launch Date:" + (flight.launchDateLocal ?? "Not available"))
                                }

                                Spacer()

                            }
                            .frame(alignment: .leading)
                            .onTapGesture {
                                self.showDetailViewScreen = true
                                self.detailViewScreenDestination = FlightDetailScreen(flight: flight)
                            }
                            Divider()
                        }
                    }
                }
                Button("Delete Local Data") {
                    deleteAllLocaleData()
                }
            }
            .padding()
            .onAppear {
                flightVM.getData(url: .spaceXUrl) { success in
                    if success {
                        self.flights = flightVM.flights
                    } else {
                        getLocalData()
                    }
                }
            }
            .onChange(of: flightVM.flights) { newValue in
                flights = newValue

                if flightsData.isEmpty {
                    addFlightsDataToCoreData(with: newValue)
                }
            }
            .navigationBarTitle(Text("SpaceX Flights"))
        }
    }

    private func getLocalData() {
        flights = flightsData.map { flight in
            Flights(flightNumber: Int(flight.flightNumber), missionName: flight.missionName, isTentative: false)
        }
    }
}

//MARK: Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceXLaunchesMainView()
    }
}
