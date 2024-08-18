import Foundation

struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let clouds: Clouds
    let dt: Int
    let timezone, id: Int
    let name: String
    let cod: Int
    
    struct Clouds: Codable {
        let all: Int
    }

    struct Coord: Codable {
        let lon, lat: Double
    }

    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity, seaLevel, grndLevel: Int

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }

    struct Weather: Codable {
        let id: Int
        let main, description, icon: String
    }
}
