//
//  BossUseCase.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Foundation

internal protocol BossUseCaseProtocol {
    func getBosses() async -> Result<[Boss], NetworkError>
    func getBoss(byID id: String) async -> Result<Boss, NetworkError>
}

internal struct BossUseCase: BossUseCaseProtocol {
    internal func getBosses() async -> Result<[Boss], NetworkError> {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return JSONReader.load("Bosses", as: [Boss].self)
    }
    
    internal func getBoss(byID id: String) async -> Result<Boss, NetworkError> {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let result = JSONReader.load("Bosses", as: [Boss].self)
        switch result {
        case let .success(bosses):
            guard let boss = bosses.first(where: { $0.id == id }) else { return .failure(.notFound) }
            return .success(boss)
        case let .failure(error):
            return .failure(error)
        }
        
    }
}
