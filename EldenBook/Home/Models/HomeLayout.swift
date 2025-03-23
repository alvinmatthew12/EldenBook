//
//  HomeLayout.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation

internal struct HomeLayout: Decodable, Equatable {
    internal enum LayoutType: String, Decodable, Equatable {
        case hero, banner, recommendation
    }
    
    internal let id: String
    internal let type: LayoutType
    internal var content: HomeLayoutContent?
    internal var recomIdentifier: String?
}

internal struct HomeLayoutContent: Decodable, Equatable {
    internal let title: String
    internal let subtitle: String
    @FailableDecodable
    internal var image: URL?
}
