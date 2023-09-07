//
//  GithubSearchView.swift
//  TCAGithubSearch
//
//  Created by AllieKim on 2023/09/07.
//

import SwiftUI

struct GithubSearchView: View {
    @StateObject private var viewModel: GithubSearchView.ViewModel = .init()
    @State private var keyword: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.results, id: \.self) {
                    Text($0)
                }
            }
            .searchable(text: $keyword)
            .navigationTitle("Github Search")
            .onSubmit(of: .search) {
                viewModel.searchWith(keyword)
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
