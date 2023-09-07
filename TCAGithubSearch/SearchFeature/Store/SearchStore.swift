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
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case search
    }

    @Dependency(\.continuousClock) var clock

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
                return .none
            default:
                return .none
            }
        }
    }
}
