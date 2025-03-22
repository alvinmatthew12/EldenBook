//
//  Boss.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Foundation

internal struct Boss: Decodable, Equatable, Identifiable {
    internal let id: String
    internal let name: String
    @FailableDecodable
    internal var image: URL?
    internal var description: String
    internal var location: String
    
    internal enum CodingKeys: String, CodingKey {
        case id, name, description, location
        case image = "image_url"
    }
}

extension Boss {
    internal static let malenia = Boss(
        id: "1",
        name: "Malenia, Blade of Miquella",
        image: URL(string: "https://eldenring.wiki.fextralife.com/file/Elden-Ring/shardbearer_malenia.png"),
        description: "Malenia is a demigod and twin sister to Miquella, known for her unmatched swordsmanship and the Scarlet Rot affliction.",
        location: "Elphael, Brace of the Haligtree"
    )
    
//    internal static let maliketh = Boss(
//        id: "2",
//        name: "Maliketh, the Black Blade",
//        image: URL(string: "https://eldenring.wiki.fextralife.com/file/Elden-Ring/maliketh_the_black_blade.png")
//    )
//    
//    internal static let radahn = Boss(
//        id: "3",
//        name: "Starscourge Radahn",
//        image: URL(string: "https://eldenring.wiki.fextralife.com/file/Elden-Ring/shardbearer_radahn.png")
//    )
}
