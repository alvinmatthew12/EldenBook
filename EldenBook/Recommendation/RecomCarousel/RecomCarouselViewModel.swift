//
//  RecomCarouselViewModel.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Combine
import Foundation

internal class RecomCarouselViewModel: ViewModel {
    internal struct State: Equatable {
        internal var identifier: String = ""
        internal var data = RecomData(title: "", items: [], seeMoreApplink: nil)
    }
    
    internal enum Action: Equatable {
        case loadData(identifier: String)
        case route(url: String)
    }
    
    @Published
    internal private(set) var state = State()
    
    private let useCase: RecomUseCaseProtocol
    private let routeEnvironment: RouteEnvironmentProtocol
    
    internal init(
        useCase: RecomUseCaseProtocol,
        routeEnvironment: RouteEnvironmentProtocol
    ) {
        self.useCase = useCase
        self.routeEnvironment = routeEnvironment
    }
    
    internal func send(_ action: Action) async {
        switch action {
        case let .loadData(identifier):
            state.identifier = identifier
            let result = await useCase.getRecommendation(identifier: identifier)
            switch result {
            case let .success(data):
                state.data = data
            case let .failure(error):
                break
            }
            
        case let .route(url):
            routeEnvironment.route(url: url)
        }
    }
}
