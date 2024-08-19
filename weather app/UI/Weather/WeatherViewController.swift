import UIKit
import Combine



class WeatherViewController: UIViewController {
    
    private let viewModel: WeatherViewModel
    private let weatherView = WeatherView()
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadWeather()
    }    
    
    private func setupBindings() {
        viewModel.$state
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .idle:
                    weatherView.update(with: viewModel.searchResult)
                    weatherView.activityIndicator(isVisible: true)
                case .loading:
                    weatherView.activityIndicator(isVisible: true)
                case .loaded(let weather, let icon):
                    weatherView.update(with: weather)
                    if let icon = icon {
                        weatherView.update(weatherIcon: icon)
                    }
                    weatherView.activityIndicator(isVisible: false)
                case .failed(let error):
                    weatherView.activityIndicator(isVisible: false)
                }
            }
            .store(in: &cancellables)
    }
}
