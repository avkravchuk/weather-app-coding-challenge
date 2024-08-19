import Foundation

protocol SearchUseCaseType {
    func searchRegion(text: String) async throws -> [SearchResult]
}

class SearchUseCase: SearchUseCaseType {
    
    let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func searchRegion(text: String) async throws -> [SearchResult] {
        do {
            return try await networkManager.searchRegion(text: text)
                .map { SearchResult(from: $0) }
        } catch let error {
            throw error
        }
    }
}
