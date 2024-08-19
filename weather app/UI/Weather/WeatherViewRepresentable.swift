import SwiftUI

struct WeatherViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = WeatherViewController
    
    // Unfortunately had to instantiate instead of DI
    // Using DI framework like Resolver would be appropriate here
    let networkManager = NetworkManager()
    
    let searchResult: SearchResult
    let units: Units
        
    func makeUIViewController(context: Context) -> WeatherViewController {
        let useCase = WeatherUseCase(networkManager: networkManager)
        let viewModel = WeatherViewModel(searchResult: searchResult, units: units, useCase: useCase)
        return WeatherViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: WeatherViewController, context: Context) {
        
    }
}
