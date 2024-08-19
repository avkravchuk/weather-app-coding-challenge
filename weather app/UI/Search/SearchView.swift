import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    @State var pickerSelection: Units = .metric
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                contentView
                Spacer()
                footnoteView
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarView }
        }
        .searchable(text: $viewModel.searchText)
        .tint(.primary)
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.state {
        case .idle:
            startSearchView
        case .loading:
            ProgressView()
        case .loaded(let searchResult):
            searchResultView(searchResult: searchResult)
        case .failed(let error):
            Text(error.localizedDescription)
        }
    }
    
    var startSearchView: some View {
        VStack(spacing: 10) {
            Image(systemName: "location.magnifyingglass")
                .font(.title)
                
            Text("Start by typing location.")
                .font(.callout)
                .multilineTextAlignment(.center)
        }
    }
    
    var emptyResultView: some View {
        VStack(spacing: 10) {
            Image(systemName: "location.magnifyingglass")
                .font(.title)
            
            Text("No results.\nPlease check your spelling.")
                .font(.callout)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    func searchResultView(searchResult: [SearchResult]) -> some View {
        if searchResult.isEmpty {
            emptyResultView
        } else {
            searchList(searchResult: searchResult)
        }
    }
    
    @ViewBuilder
    func searchList(searchResult: [SearchResult]) -> some View {
        List {
            ForEach(searchResult) { result in
                NavigationLink {
                    WeatherViewRepresentable(searchResult: result, units: viewModel.units)
                } label: {
                    searchResultRow(model: result)
                }
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    func searchResultRow(model: SearchResult) -> some View {
        HStack(spacing: 5) {
            Text(model.emojiFlag)
            Text(model.name)
            
            if let state = model.state {
                Text(state)
            }
            
            Text(model.countryName)
        }
    }
    
    var footnoteView: some View {
        Text("Weather data is provided by OpenWeather.")
            .font(.caption)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
    }
    
    var toolbarView: some View {
        Menu {
            Picker("Units", selection: $viewModel.units) {
                ForEach(Units.allCases) { units in
                    Text(units.rawValue)
                }
            }
        } label: {
            Image(systemName: "gear")
                .foregroundStyle(.foreground)
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(searchUseCase: SearchUseCase()))
}
