//
//  RouteResolver.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation

public enum Route {
    case home
    case bosses
    case bossDetail(bossID: String)
}

extension Route {
    internal var pattern: String {
        switch self {
        case .home:
            return "/home"
        case .bosses:
            return "/bosses"
        case .bossDetail:
            return "/boss/:id"
        }
    }
}

extension Route: CaseIterable {
    public static var allCases: [Route] {
        [
            .home,
            .bosses,
            .bossDetail(bossID: "")
        ]
    }
}
