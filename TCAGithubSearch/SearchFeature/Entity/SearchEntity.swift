//
//  SearchEntity.swift
//  TCAGithubSearch
//
//  Created by AllieKim on 2023/09/07.
//

import Foundation

struct SearchEntity: Decodable, Equatable, Sendable {
    var items: [Result]

    struct Result: Decodable, Equatable, Sendable {
        var name: String

        enum CodingKeys: String, CodingKey {
            case name = "full_name"
        }
    }
}

// MARK: - Mock data

extension SearchEntity {
    static let mock = Self(
        items: [
            SearchEntity.Result(name: "Swift"),
            SearchEntity.Result(name: "SwiftyJSON"),
            SearchEntity.Result(name: "SwiftGuide"),
            SearchEntity.Result(name: "SwiftterSwift")
        ]
    )
}
