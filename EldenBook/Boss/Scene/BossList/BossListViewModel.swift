//
//  BossListViewModel.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Combine

internal class BossListViewModel: ViewModel {
    internal struct State: Equatable {
        internal var bosses: [Boss] = []
    }
    
    internal enum Action: Equatable {
        case loadData
    }
    
    @Published
    internal private(set) var state = State()
    
    private let useCase: BossUseCaseProtocol
    
    internal init(useCase: BossUseCaseProtocol) {
        self.useCase = useCase
    }
    
    internal func send(_ action: Action) async {
        switch action {
        case .loadData:
            let response = await useCase.getBosses()
            switch response {
            case let .success(bosses):
                state.bosses = bosses
            case let .failure(error):
                print(error)
                break
            }
        }
    }
}
