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

    var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            NavigationView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Request count : \(viewStore.requestCount)")
                            .font(.title)
                        Text("Keyword : \(viewStore.keyword)")
                            .font(.body)
                        Text("Previous keyword : \(viewStore.previousKeyword)")
                            .font(.body)
                    }
                    .padding(.leading, 20)

                    List {
                        ForEach(viewStore.searchResults, id: \.self) {
                            Text($0)
                        }
                    }
                    .searchable(text: viewStore.$keyword)
                    .navigationTitle("Github Search")
                }
            }
        }
    }
}
