//
//  RecomItem.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation

internal struct RecomData: Decodable, Equatable {
    internal let title: String
    internal let items: [RecomItem]
    internal let seeMoreApplink: String?
}

internal struct RecomItem: Decodable, Equatable, Identifiable {
    internal let id: String
    internal let title: String
    @FailableDecodable
    internal var image: URL?
    internal var applink: String
}
