import SwiftUI
import Alamofire

@main
struct weather_appApp: App {
    let networkManager = NetworkManager()
    @ObservedObject var reachabilityManager = ReachabilityManager()
    
    var body: some Scene {
        WindowGroup {
            switch reachabilityManager.networkStatus {
            case .checking:
                ProgressView()
            case .reachable:
                SearchView(viewModel: SearchViewModel(searchUseCase: SearchUseCase(networkManager: networkManager)))
            case .unreachable:
                NetworkErrorView()
            }
        }
    }
}
