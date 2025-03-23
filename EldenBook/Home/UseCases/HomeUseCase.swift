//
//  HomeUseCase.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation
import Combine

internal protocol HomeUseCaseProtocol {
    func getHomeLayout() -> AnyPublisher<Result<[HomeLayout], NetworkError>, Never>
}

internal struct HomeUseCase: HomeUseCaseProtocol {
    internal func getHomeLayout() -> AnyPublisher<Result<[HomeLayout], NetworkError>, Never> {
        Future<Result<[HomeLayout], NetworkError>, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                let mock: [HomeLayout] = [
                    .init(
                        id: "1",
                        type: .hero,
                        content: HomeLayoutContent(
                            title: "Arise, Tarnished!",
                            subtitle: "Step forth from the fog of grace. Your legend is yet to be forged.",
                            image: URL(string: "https://eldenring.wiki.fextralife.com/file/Elden-Ring/elden-ring-wiki-guide-walkthrough-background-min.jpg")
                        )
                    ),
                    .init(
                        id: "2",
                        type: .banner,
                        content: HomeLayoutContent(
                            title: "Choose Thy Origin!",
                            subtitle: "The path ahead is forged by your beginning.",
                            image: URL(string: "https://eldenring.wiki.fextralife.com/file/Elden-Ring/bloody-wolf-class-network-test-elden-ring-wiki-guide-270.jpg")
                        )
                    ),
                    .init(
                        id: "3",
                        type: .recommendation,
                        recomIdentifier: "Bosses"
                    )
                ]
                promise(.success(.success(mock)))
            }
        }
        .subscribe(on: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
