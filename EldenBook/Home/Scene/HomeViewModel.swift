//
//  HomeViewModel.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Combine

internal struct HomeViewModel {
    internal struct Input {
        internal let didLoad: AnyPublisher<Void, Never>
    }
    
    internal struct Output {
        internal let sections: AnyPublisher<[HomeSection], Never>
    }
    
    private let useCase: HomeUseCaseProtocol
    
    internal init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }
    
    internal func transform(input: Input) -> Output {
        let response = useCase.getHomeLayout()
        
        let sections = response
            .compactMap { result -> [HomeLayout]? in
                guard case let .success(layout) = result else { return nil }
                return layout
            }
            .map { layout -> [HomeSection] in
                layout.compactMap { layout -> HomeSection? in
                    switch layout.type {
                    case .hero:
                        guard let content = layout.content else { return nil }
                        return .hero(content)
                        
                    case .banner:
                        guard let content = layout.content else { return nil }
                        return .banner(content)
                        
                    case .recommendation:
                        guard let identifier = layout.recomIdentifier else { return nil }
                        return .recommendation(identifier: identifier)
                        
                    default:
                        return nil
                    }
                }
            }
            .eraseToAnyPublisher()
        
        return Output(
            sections: sections
        )
    }
}
