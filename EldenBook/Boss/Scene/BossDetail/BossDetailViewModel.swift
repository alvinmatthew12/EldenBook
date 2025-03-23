//
//  BossDetailViewModel.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Combine

internal class BossDetailViewModel: ViewModel {
    internal enum ViewState: Equatable {
        case loading
        case error(NetworkError)
        case boss(Boss)
    }
    
    internal struct State: Equatable {
        internal let bossID: String
        internal var viewState: ViewState = .loading
    }
    
    internal enum Action: Equatable {
        case loadData
    }
    
    @Published
    internal private(set) var state: State
    
    private let useCase: BossUseCaseProtocol
    
    internal init(
        bossID: String,
        useCase: BossUseCaseProtocol
    ) {
        _state = Published(initialValue: State(bossID: bossID))
        self.useCase = useCase
    }
    
    internal func send(_ action: Action) async {
        switch action {
        case .loadData:
            let result = await useCase.getBoss(byID: state.bossID)
            switch result {
            case let .success(boss):
                state.viewState = .boss(boss)
            case let .failure(error):
                state.viewState = .error(error)
            }
        }
    }
}
