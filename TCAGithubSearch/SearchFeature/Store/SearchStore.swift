//
//  SearchStore.swift
//  TCAGithubSearch
//
//  Created by AllieKim on 2023/09/07.
//

import ComposableArchitecture
import Foundation

struct SearchStore: Reducer {
    struct State: Equatable {
        @BindingState var keyword: String = ""
        var requestCount: Int = 0
        var searchResults: [String] = []
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case search

        case searchDataLoaded(TaskResult<SearchEntity>)
    }

    @Dependency(\.continuousClock) private var clock
    @Dependency(\.searchClient) private var searchClient

    private enum Debounce {
        case SearchID
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.$keyword):
                return .run { send in
                    try await clock.sleep(for: .seconds(1)) // debounce를 추가한다.
                    await send(.search)
                }
                .cancellable(id: Debounce.SearchID.self, cancelInFlight: true)

            case .search:
                state.requestCount += 1
                return .run { [keyword = state.keyword] send in
                    let result = await TaskResult {
                        try await searchClient.searchWith(keyword)
                    }
                    await send(.searchDataLoaded(result))
                }

            case let .searchDataLoaded(.success(searchEntity)):
                state.searchResults = searchEntity.items.map(\.name)
                return .none

            case let .searchDataLoaded(.failure(error)):
                state.searchResults = []
                print(error)
                return .none

            default:
                return .none
            }
        }
    }
}
