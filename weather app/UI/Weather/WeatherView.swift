import UIKit

class WeatherView: UIView {
    
    private let weatherIconSize: CGFloat = 100
    private let refreshButtonSize: CGFloat = 30
    
    // MARK: - Subviews
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var weatherIconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 50, weight: .bold)
        return view
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var refreshButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        view.addAction(UIAction(handler: { _ in
            self.onReloadButtonTap?()
        }), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Public properties
    
    var onReloadButtonTap: (() -> Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func update(with searchResult: SearchResult) {
        cityLabel.text = "\(searchResult.emojiFlag) \(searchResult.name), \(searchResult.countryName)"
    }
    
    func update(with currentWeather: CurrentWeather) {
        temperatureLabel.text = String(Int(currentWeather.temperature)) + "°"
        feelsLikeLabel.text = "Feels like: " + String(Int(currentWeather.feelsLike)) + "°"
        weatherDescriptionLabel.text = currentWeather.weatherDescription
    }
    
    func update(weatherIcon: UIImage) {
        weatherIconView.image = weatherIcon
    }
    
    func activityIndicator(isVisible: Bool) {
        isVisible ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        activityIndicator.isHidden = !isVisible
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: Size.paddingLarge),
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(weatherIconView)
        NSLayoutConstraint.activate([
            weatherIconView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: Size.paddingExtraLarge),
            weatherIconView.widthAnchor.constraint(equalToConstant: weatherIconSize),
            weatherIconView.heightAnchor.constraint(equalToConstant: weatherIconSize),
            weatherIconView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(weatherDescriptionLabel)
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherIconView.bottomAnchor),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: Size.paddingExtraLarge),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(feelsLikeLabel)
        NSLayoutConstraint.activate([
            feelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Size.paddingMedium),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(refreshButton)
        NSLayoutConstraint.activate([
            refreshButton.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: Size.paddingMedium),
            refreshButton.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            refreshButton.widthAnchor.constraint(equalToConstant: refreshButtonSize),
            refreshButton.heightAnchor.constraint(equalToConstant: refreshButtonSize)
        ])
    }
}
