import SwiftUI

@main
struct weather_appApp: App {
    var body: some Scene {
        WindowGroup {
            // if has internet
            SearchView(viewModel: SearchViewModel(searchUseCase: SearchUseCase()))
            
            // else
            
        }
    }
}
