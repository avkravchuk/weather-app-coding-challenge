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
        let add = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadTapped))
        navigationItem.rightBarButtonItem = add
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let add = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadTapped))
        navigationItem.rightBarButtonItem = add
        
    }
    
    @objc
    func reloadTapped() {
        
    }
    
    
    private func setupBindings() {
        weatherView.update(with: viewModel.searchResult)
        
        viewModel.$state
            .sink { state in
                switch state {
                case .idle:
                    print(state)
                case .loading:
                    print(state)
                case .loaded(let weather, let icon):
                    self.weatherView.update(with: weather)
                    if let icon = icon {
                        self.weatherView.update(weatherIcon: icon)
                    }
                case .failed(let error):
                    print(state)
                }
            }
            .store(in: &cancellables)
    }
}
