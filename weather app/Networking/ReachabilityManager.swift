import Foundation
import Alamofire

enum ReachabilityStatus {
    case checking
    case reachable
    case unreachable
}

class ReachabilityManager: ObservableObject {
    
    @Published var networkStatus: ReachabilityStatus = .checking
    
    init() {
        startMonitoringNetwork()
    }
    
    private func startMonitoringNetwork() {
        NetworkReachabilityManager.default?.startListening { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .reachable:
                networkStatus = .reachable
            default:
                networkStatus = .unreachable
            }
        }
    }
}
