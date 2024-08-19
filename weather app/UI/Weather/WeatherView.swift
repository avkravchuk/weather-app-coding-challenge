import UIKit

class WeatherView: UIView {
    
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
    
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(weatherIconView)
        NSLayoutConstraint.activate([
            weatherIconView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 50),
            weatherIconView.widthAnchor.constraint(equalToConstant: 100),
            weatherIconView.heightAnchor.constraint(equalToConstant: 100),
            weatherIconView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(weatherDescriptionLabel)
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherIconView.bottomAnchor),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 50),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(feelsLikeLabel)
        NSLayoutConstraint.activate([
            feelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
