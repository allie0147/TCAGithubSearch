//
//  GithubSearchView.swift
//  TCAGithubSearch
//
//  Created by AllieKim on 2023/09/07.
//

import ComposableArchitecture
import SwiftUI

struct GithubSearchView: View {
    let store: StoreOf<SearchStore>

    @StateObject private var viewModel: GithubSearchView.ViewModel = .init()
    @State private var keyword: String = ""

    var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            NavigationView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Request count : \(viewStore.requestCount)")
                            .font(.title)
                    }
                    .padding(.leading, 20)

                    List {
                        ForEach(viewModel.results, id: \.self) {
                            Text($0)
                        }
                    }
                    .searchable(text: viewStore.$keyword)
                    .navigationTitle("Github Search")
                    .onSubmit(of: .search) {
                        viewModel.searchWith(viewStore.keyword)
                    }
                }
            }
        }
    }
}

extension GithubSearchView {
    class ViewModel: ObservableObject {
        @Published var results: [String] = []

        func searchWith(_ keyword: String) {
            SearchClient.shared.fetchSearchResults(keyword) { [weak self] results in
                self?.results = results
            }
        }
    }
}
