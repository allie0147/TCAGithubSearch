//
//  TCAGithubSearchTests.swift
//  TCAGithubSearchTests
//
//  Created by AllieKim on 2023/09/07.
//

import ComposableArchitecture
@testable import TCAGithubSearch
import XCTest

final class TCAGithubSearchTests: XCTestCase {
    var sut: TestStoreOf<SearchStore>!
    var testClock: TestClock = .init()

    override func setUpWithError() throws {
        try super.setUpWithError()
        initDefaultStore()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func initDefaultStore() {
        sut = TestStore(initialState: SearchStore.State()) {
            SearchStore()
        } withDependencies: {
            $0.continuousClock = testClock
        }
    }

    func test_search_keyword() async {
        await sut.send(.binding(.set(\.$keyword, "Swift"))) {
            $0.keyword = "Swift"
        }
        XCTAssert(sut.state.keyword == "Swift")

        await testClock.advance(by: .seconds(1))
        await testClock.run()

        await sut.receive(.search) {
            $0.requestCount += 1
        }
    }
}
