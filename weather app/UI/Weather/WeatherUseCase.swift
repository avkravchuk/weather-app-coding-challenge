import Foundation
import UIKit

protocol WeatherUseCaseType {
    func loadWeather(for searchResult: SearchResult) async throws -> CurrentWeather
    func loadWeatherIcon(weatherCode: String) async throws -> UIImage?
}

class WeatherUseCase: WeatherUseCaseType {
    
    let networkManager = NetworkManager()
    
    func loadWeather(for searchResult: SearchResult) async throws -> CurrentWeather {
        do {
            let result = try await networkManager.loadWeather(lat: searchResult.lat, lon: searchResult.lon)
            return CurrentWeather(from: result)
        } catch let error {
            throw error
        }
    }
    
    func loadWeatherIcon(weatherCode: String) async throws -> UIImage? {
        do {
            let result = try await networkManager.loadWeatherIcon(weatherCode: weatherCode)
            return UIImage(data: result)
        } catch let error {
            throw error
        }
    }
}
