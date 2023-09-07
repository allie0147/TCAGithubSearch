//
//  SearchClient.swift
//  TCAGithubSearch
//
//  Created by AllieKim on 2023/09/07.
//

import ComposableArchitecture
import Foundation

struct SearchClient {
    var searchWith: @Sendable (String) async throws -> SearchEntity
}

extension DependencyValues {
    var searchClient: SearchClient {
        get { self[SearchClient.self] }
        set { self[SearchClient.self] = newValue }
    }
}

// MARK: - Live API implementation

extension SearchClient: DependencyKey {
    static let liveValue = SearchClient(
        searchWith: { keyword in
            guard let url = URL(string: "https://api.github.com/search/repositories?q=\(keyword)") else {
                throw APIError.invalidURL
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(SearchEntity.self, from: data)
        }
    )
}

extension SearchClient: TestDependencyKey {
    static let previewValue = Self(
        searchWith: { _ in .mock }
    )

    static let testValue = Self(
        searchWith: unimplemented("\(Self.self).search")
    )
}
