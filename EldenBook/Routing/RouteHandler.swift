//
//  RouteHandler.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation
import SwiftUI
import UIKit

public final class RouteHandler {
    public static let shared = RouteHandler()
    
    public init() { }
    
    public func route(url: String) {
        guard let url = URL(string: url) else { return }
        guard let r = match(path: normalizedPath(from: url)) else { return }
        route(to: r)
    }
    
    public func route(to route: Route) {
        guard let navigationController = UIApplication.shared.topViewController?.navigationController else { return }
        navigationController.setNavigationBarHidden(false, animated: false)
        
        switch route {
        case .home:
            navigationController.popToRootViewController(animated: true)
            
        case .bosses:
            let hosting = UIHostingController(rootView: BossListView())
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.pushViewController(hosting, animated: true)
            
        case let .bossDetail(id):
            let hosting = UIHostingController(rootView: BossDetailView(bossID: id))
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.pushViewController(hosting, animated: true)
        }
    }
    
    private func normalizedPath(from url: URL) -> String {
        if let host = url.host {
            return "/" + host + url.path
        } else {
            return url.path
        }
    }
    
    private func match(path: String) -> Route? {
        let pathComponents = path.split(separator: "/").map(String.init)

        for route in Route.allCases {
            let patternComponents = route.pattern.split(separator: "/").map(String.init)
            
            print(pathComponents, patternComponents)

            guard pathComponents.count == patternComponents.count else { continue }

            var params: [String: String] = [:]
            var isMatch: Bool = true
            
            for (pathComp, patternComp) in zip(pathComponents, patternComponents) {
                if patternComp.hasPrefix(":") {
                    let key = String(patternComp.dropFirst())
                    params[key] = pathComp
                } else if pathComp != patternComp {
                    isMatch = false
                    break
                }
            }
            
            guard isMatch else { continue }
            
            switch route {
            case .home:
                return .home
            case .bosses:
                return .bosses
            case .bossDetail:
                if let id = params["id"] {
                    return .bossDetail(bossID: id)
                }
            }
        }

        return nil
    }
}
