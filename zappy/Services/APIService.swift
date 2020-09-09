//
//  Created by Joh Robbins on 22/8/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import Foundation

class APIService {

    enum RequestError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }

    enum Result<Weather> {
        case success(Weather)
        case failure(RequestError)
    }

    func getWeather(for location: Location, completion: @escaping (Result<Weather>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.darksky.net"
        components.path = "/forecast/\(darkWeatherAPIKey)/\(location.latitude),\(location.longitude)"
        components.queryItems = [URLQueryItem(name: "exclude", value: "minutely,hourly,flags"), //daily
                                 URLQueryItem(name: "units", value: "auto")]

        guard let url = components.url else {
            fatalError("Invalid URL components.")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard error == nil else {
               completion(Result.failure(RequestError.networkError(error!)))
               return
            }

            guard let data = data else {
               completion(Result.failure(RequestError.dataNotFound))
               return
            }

            do {
               let decodedObject = try JSONDecoder().decode(Weather.self, from: data)
               completion(Result.success(decodedObject))
            } catch let error {
               completion(Result.failure(RequestError.jsonParsingError(error as! DecodingError)))
            }
        }
        .resume()
    }
}
