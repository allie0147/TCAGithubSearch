//
//  SearchClient.swift
//  TCAGithubSearch
//
//  Created by AllieKim on 2023/09/07.
//

import Foundation

final class SearchClient {
    static let shared: SearchClient = .init()

    private init() {}

    func fetchSearchResults(_ keyword: String, _ completion: @escaping ([String]) -> ()) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(keyword)") else {
            return
        }
        URLSession.shared.dataTask(
            with: URLRequest(url: url)
        ) { data, response, error in
            guard error == nil else {
                return
            }
            if let data,
               let response = response as? HTTPURLResponse,
               response.statusCode == 200 {
                do {
                    let entity = try JSONDecoder().decode(SearchEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(entity.items.map(\.name))
                    }
                } catch let err {
                    print("Decoding Error")
                    print(err.localizedDescription)
                }
            }
        }
        .resume()
    }
}
