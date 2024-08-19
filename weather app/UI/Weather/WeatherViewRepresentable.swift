import SwiftUI

struct WeatherViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = WeatherViewController
    
    let searchResult: SearchResult
    let units: Units
    
    func makeUIViewController(context: Context) -> WeatherViewController {
        let useCase = WeatherUseCase()
        let viewModel = WeatherViewModel(searchResult: searchResult, units: units, useCase: useCase)
        return WeatherViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: WeatherViewController, context: Context) {
        
    }
}
