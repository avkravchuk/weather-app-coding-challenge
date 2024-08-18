import Foundation

struct RegionModel: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
