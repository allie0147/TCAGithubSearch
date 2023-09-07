# TCAGithubSearch [![TCA v1.0.0](https://img.shields.io/badge/TCA-v1.0.0-2a2a2a)](https://github.com/pointfreeco/swift-composable-architecture)   

### TCA Github Search Example App
Let's Swift 2022 [워크샵 402C](https://www.youtube.com/watch?v=2DO420E9lvs) 영상을 참고하여 제작했습니다.   

## [Basic](https://github.com/allie0147/TCAGithubSearch/tree/Basic)
- 기본적인 프로젝트 셋팅입니다.
- `SwiftUI`와 MVVM 패턴으로 기본적인 `feature`를 구성합니다.

## [SearchStore](https://github.com/allie0147/TCAGithubSearch/tree/SearchStore)
- `SearchStore`를 만들어 `View`와 연결합니다.
- `@BindingState`와 `BindableAction`/`BindingAction`을 사용하여 양방향 데이터 바인딩을 구현합니다.
- `.continuousClock`을 활용하여 바인딩된 `keyword`에 `debounce`를 추가합니다.
- `search` action 횟수를 `requestCount`에 표출합니다.
- 테스트 코드에 `TestClock`을 추가하여 `debounce`를 구현합니다.


## [SearchClient](https://github.com/allie0147/TCAGithubSearch/tree/SearchClient)
- 네트워킹을 위한 `SearchClient`를 만들어 `SearchStore`에 주입합니다.
- `SearchStore`에서 API를 fetch하여 `succss`와 `failure`케이스를 작성합니다.
- 받아 온 데이터를 화면에 노출합니다.
- 테스트 코드를 위한 mock을 `SearchClient`와 `SearchEntity`에 작성합니다.
- 위의 내용을 테스트 코드로 작성합니다.


## [Operator](https://github.com/allie0147/TCAGithubSearch/tree/Operator)
- 현재 키워드와 이전 키워드를 화면에 띄우기 위해 `seach` action이 실행될 때 `Effect.concatenate()`를 사용하여 두 개의 Effect를 합칩니다.
- 위의 내용을 테스트 코드로 작성합니다.

