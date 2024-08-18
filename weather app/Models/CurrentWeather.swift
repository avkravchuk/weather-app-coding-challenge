import Foundation

struct CurrentWeather {
    let weather: String
    let weatherDescription: String
    let temperature: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let icon: String
    
    init(from weatherModel: WeatherModel) {
        weather = weatherModel.weather[0].main
        weatherDescription = weatherModel.weather[0].description
        temperature = weatherModel.main.temp
        feelsLike = weatherModel.main.feelsLike
        tempMin = weatherModel.main.tempMin
        tempMax = weatherModel.main.tempMax
        pressure = weatherModel.main.pressure
        humidity = weatherModel.main.humidity
        icon = weatherModel.weather[0].icon
    }
}
