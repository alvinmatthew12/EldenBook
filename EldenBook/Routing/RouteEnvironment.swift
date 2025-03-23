//
//  RouteEnvironment.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 24/03/25.
//

import Foundation

public protocol RouteEnvironmentProtocol {
    func route(to route: Route) -> Void
    func route(url: String) -> Void
}

public struct RouteEnvironment: RouteEnvironmentProtocol {
    private let handler = RouteHandler()
    
    public func route(to route: Route) {
        handler.route(to: route)
    }
    
    public func route(url: String) {
        handler.route(url: url)
    }
}
