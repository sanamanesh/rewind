import Foundation

enum APIError: String, Error {
    case networkError
    case invalidURL
}

class APICalls {
    static let instance = APICalls()

    func getPlaceCoordinates(storeName: String, completion: @escaping (Result<[Coord], Error>) -> Void) {
        let cityName = "Philadelphia"
        let apiKey = "AIzaSyA0XfyxOfpCZqrwhKWHee7bbcdib6Z8CIE"
        
        // Encode the store name and city name for URL
        guard let encodedStoreName = storeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "EncodingError", code: -1, userInfo: nil)))
            return
        }
        
        // Construct the API request URL with the 'geometry' parameter
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(encodedStoreName)+\(encodedCityName)&key=\(apiKey)&fields=name,geometry,formatted_address"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "URLError", code: -1, userInfo: nil)))
            return
        }
        
        // Perform the API request
        //share.data
        //takes in completein handler and calls this function when done
        //.data works with async stuff
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "UnknownError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                // Parse the JSON response
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let results = json?["results"] as? [[String: Any]] {
                    var coords: [Coord] = []
                    for result in results {
                        if let geometry = result["geometry"] as? [String: Any], let location = geometry["location"] as? [String: Any] {
                            if let latitude = location["lat"] as? Double, let longitude = location["lng"] as? Double {
                                let address = result["formatted_address"] as? String ?? ""
                                let coord = Coord(addr: address, lat: latitude, lng: longitude)
                                coords.append(coord)
                            }
                        }
                    }
                    completion(.success(coords))
                } else {
                    completion(.failure(NSError(domain: "NoResultsError", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }


}
