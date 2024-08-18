import Foundation
import Alamofire

protocol NetworkManagerType {
    func searchRegion(text: String) async throws -> [RegionModel]
    func loadWeather(lat: Double, lon: Double) async throws -> WeatherModel
    func loadWeatherIcon(weatherCode: String) async throws -> Data
}

class NetworkManager: NetworkManagerType {
    
    func searchRegion(text: String) async throws -> [RegionModel] {
        let url = "https://api.openweathermap.org/geo/1.0/direct"
        
        let parameters = [
            "q" : text,
            "limit" : "5",
            "appid" : NetworkNames.apiKey
        ]

        let result = await AF.request(url, parameters: parameters)
            .serializingDecodable([RegionModel].self)
            .result
        
        debugPrint(result)
        
        switch result {
        case .success(let regions):
            return regions
        case .failure(let error):
            throw error
        }
    }
    
    func loadWeather(lat: Double, lon: Double) async throws -> WeatherModel {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        
        let parameters = [
            "lat" : String(lat),
            "lon" : String(lon),
            "appid" : NetworkNames.apiKey
        ]
        
        let result = await AF.request(url, parameters: parameters)
            .serializingDecodable(WeatherModel.self)
            .result
        
        debugPrint(result)
        
        switch result {
        case .success(let weather):
            return weather
        case .failure(let error):
            throw error
        }
    }
    
    func loadWeatherIcon(weatherCode: String) async throws -> Data {
        let url =  "https://openweathermap.org/img/wn/\(weatherCode)@2x.png"
        
        return try await withUnsafeThrowingContinuation { continuation in
            AF.request(url)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
