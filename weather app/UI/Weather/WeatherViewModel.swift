import Foundation
import UIKit

@MainActor
class WeatherViewModel {
    
    // MARK: - State
    
    enum State {
        case idle
        case loading
        case loaded(CurrentWeather, UIImage?)
        case failed(Error)
    }
    
    // MARK: - Public properties
    
    @Published private(set) var state: State = .idle
    
    // MARK: - Private properties
    
    let searchResult: SearchResult
    private let useCase: WeatherUseCaseType
    private let units: Units
    
    // MARK: - Init
    
    init(searchResult: SearchResult, units: Units, useCase: WeatherUseCaseType) {
        self.searchResult = searchResult
        self.useCase = useCase
        self.units = units
    }
    
    // MARK: - Public methods
    
    func loadWeather() {
        state = .loading
        
        Task {
            do {
                let currentWeather = try await useCase.loadWeather(for: searchResult, units: units)
                let weatherIcon = try await useCase.loadWeatherIcon(weatherCode: currentWeather.icon)
                state = .loaded(currentWeather, weatherIcon)
            } catch let error {
                state = .failed(error)
            }
        }
    }
}
