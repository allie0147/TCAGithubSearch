//
//  TCAGithubSearchApp.swift
//  TCAGithubSearch
//
//  Created by AllieKim on 2023/09/07.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCAGithubSearchApp: App {
    var body: some Scene {
        WindowGroup {
            GithubSearchView(
                store: .init(
                    initialState: SearchStore.State(),
                    reducer: { SearchStore()._printChanges() }
                )
            )
        }
    }
}
