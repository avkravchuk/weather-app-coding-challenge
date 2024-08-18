import SwiftUI

struct WeatherViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = WeatherViewController
    
    let searchResult: SearchResult
    
    func makeUIViewController(context: Context) -> WeatherViewController {
        let useCase = WeatherUseCase()
        let viewModel = WeatherViewModel(searchResult: searchResult, useCase: useCase)
        return WeatherViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: WeatherViewController, context: Context) {
        
    }
}
