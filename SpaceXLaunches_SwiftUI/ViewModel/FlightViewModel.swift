//
//  FlightViewModel.swift
//  SpaceXLaunch_SwiftUI
//
//  Created by Krunal Mistry on 3/12/22.
//

import Foundation

class FlightViewModel: ObservableObject {

    //MARK: Properties
    let apiHandler = APIHandler.shared
    @Published var flights:[Flights] = []
    private var error: Error?

    //MARK: Methods
    ///We use this method to get flight data from API
    func getData(url: EndPoint, completionHandler : @escaping (_ success: Bool) -> ()) {

        apiHandler.fetchData(url: url.rawValue) { [weak self] data in
            switch data {
            case .failure(let error):
                self?.error = error
                completionHandler(false)
            case .success(let data):
                DispatchQueue.main.async {
                    self?.flights = data
                    completionHandler(true)
                }
            }
        }

        self.flights.sort { x, y in
            return x.launchDateUnix ?? 0 > y.launchDateUnix ?? 0
        }

    }
}
