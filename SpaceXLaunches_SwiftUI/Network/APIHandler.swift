//
//  APIHandler.swift
//  SpaceXLaunch_SwiftUI
//
//  Created by Krunal Mistry on 3/12/22.
//

import Foundation

// Enum to handle Server errors
enum APIHandlerError: Error {
   case fetchError, httpError, decodeError
}

class APIHandler {
    private init() {}
    static let shared = APIHandler()

    class APIHandler {
        static let shared = APIHandler()

        func fetchData( url: String, completionHandler: @escaping (Result<[Flights], Error>)-> Void) {

            guard let strUrl = URL(string: url) else { return }
            let request = URLRequest(url: strUrl)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("\(#function) \(error)")
                    completionHandler(.failure(APIHandlerError.fetchError))
                }

                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("\(#function) \(response.debugDescription)")
                    completionHandler(.failure(APIHandlerError.httpError))
                    return
                }

                if let data1 = data {
                    do{
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let jsonArray = try decoder.decode([Flights].self ,from : data1)
                        completionHandler(.success(jsonArray))
                    } catch {
                        print("\(#function) \(error)")
                        completionHandler(.failure(APIHandlerError.decodeError))
                    }
                }
            }.resume()
        }
    }
}
