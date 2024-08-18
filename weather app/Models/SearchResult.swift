import Foundation

struct SearchResult: Identifiable {
    let id = UUID()
    
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    var emojiFlag: String {
        emojiFlag(country)
    }
    
    var countryName: String {
        Locale.current.localizedString(forRegionCode: country) ?? country
    }
    
    init(from regionModel: RegionModel) {
        name = regionModel.name
        lat = regionModel.lat
        lon = regionModel.lon
        country = regionModel.country
        state = regionModel.state
    }

    private func emojiFlag(_ country: String) -> String {
        let base : UInt32 = 127397
        var string = ""
        for scalar in country.uppercased().unicodeScalars {
            string.unicodeScalars.append(UnicodeScalar(base + scalar.value)!)
        }
        return string
    }
}
