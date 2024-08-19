import Foundation

enum Units: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case metric
    case imperial
}
