import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    // MARK: - State
    
    enum State {
        case idle
        case loading
        case loaded([SearchResult])
        case failed(Error)
    }
    
    // MARK: - Public properties
    
    @Published var searchText = ""
    @Published var units: Units = .metric
    @Published private(set) var state: State = .idle
    
    // MARK: - Private
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let useCase: SearchUseCaseType
    
    // MARK: - Init
    
    init(searchUseCase: SearchUseCaseType) {
        self.useCase = searchUseCase
        setupBindings()
    }
    
    // MARK: - Public methods
    
    func cancelSearch() {
        state = .idle
    }
    
    // MARK: - Private methods
    
    private func setupBindings() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { text in
                if text.isEmpty {
                    self.state = .idle
                } else {
                    self.state = .loading
                    Task {
                        await self.load(text: text)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func load(text: String) async {
        do {
            state = .loaded(try await useCase.searchRegion(text: text))
        } catch let error {
            state = .failed(error)
        }
    }
}
