//
//  RecomUseCase.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation

internal protocol RecomUseCaseProtocol {
    func getRecommendation(identifier: String) async -> Result<RecomData, NetworkError>
}

internal struct RecomUseCase: RecomUseCaseProtocol {
    internal func getRecommendation(identifier: String) async -> Result<RecomData, NetworkError> {
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        if identifier == "Bosses" {
            let result = JSONReader.load("Bosses", as: [Boss].self)
            switch result {
            case let .success(bosses):
                let items = bosses.prefix(4)
                    .map { boss -> RecomItem in
                        RecomItem(
                            id: boss.id,
                            title: boss.name,
                            image: boss.image,
                            applink: "eb://boss/\(boss.id)"
                        )
                    }
                let data = RecomData(
                    title: "Bosses",
                    items: items,
                    seeMoreApplink: "eb://bosses"
                )
                return .success(data)
            case let .failure(error):
                return .failure(error)
            }
        } else {
            return .failure(.notFound)
        }
    }
}
