//
//  NetworkError.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Foundation

public enum NetworkError: Error {
    case decodeError
    case notFound
    case serverError
}
