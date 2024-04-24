import Foundation

enum APIError: String, Error {
    case networkError
    case invalidURL
}

class APICalls {
    static let instance = APICalls()
    
    //fix to deal with address
    func getLocation(city: String) async throws -> [Location]  {
        let urlString = "https://nominatim.openstreetmap.org/search?q=\(city)&addressdetails=1&format=json"
        
        print("1")
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        print("2")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print("3")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("4")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode <= 299 else {
            print("4.5")
            throw APIError.networkError
        }
        
        print("5")
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
        } else {
            print("Failed to convert JSON data to string")
        }
        
        return try JSONDecoder().decode([Location].self, from: data)
    }
    
    //api key: AIzaSyA0XfyxOfpCZqrwhKWHee7bbcdib6Z8CIE
    func getAddressForPlace(storeName: String) {
        var cityName = "Philadelphia"
        var apiKey = "AIzaSyA0XfyxOfpCZqrwhKWHee7bbcdib6Z8CIE"
        // Encode the store name and city name for URL
        guard let encodedStoreName = storeName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Error encoding store name or city name")
            return
        }
        
        // Construct the API request URL
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(encodedStoreName)+\(encodedCityName)&key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Error constructing URL")
            return
        }
        
        // Perform the API request
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                // Parse the JSON response
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let results = json?["results"] as? [[String: Any]], let firstResult = results.first {
                    if let address = firstResult["formatted_address"] as? String {
                        print("Address of \(storeName) in \(cityName): \(address)")
                    } else {
                        print("Address not found")
                    }
                } else {
                    print("No results found")
                }
            } catch {
                print("Error parsing JSON:", error.localizedDescription)
            }
        }
        
        task.resume()
    }

}
