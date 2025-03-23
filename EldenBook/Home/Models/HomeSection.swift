//
//  HomeSection.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation

internal enum HomeSection: Hashable, Equatable {
    case hero(HomeLayoutContent)
    case banner(HomeLayoutContent)
    case recommendation(identifier: String)
    
    internal var id: String {
        switch self {
        case .hero: "hero"
        case .banner: "banner"
        case .recommendation: "recommendation"
        }
    }
    
    internal func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
