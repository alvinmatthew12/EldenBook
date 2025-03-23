//
//  UIApplication+Ext.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 24/03/25.
//

import UIKit

extension UIApplication {
    public var topViewController: UIViewController? {
        guard let root = connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?
            .rootViewController else {
            return nil
        }

        return topViewController(for: root)
    }

    private func topViewController(for root: UIViewController) -> UIViewController {
        if let presented = root.presentedViewController {
            return topViewController(for: presented)
        } else if let nav = root as? UINavigationController {
            return topViewController(for: nav.visibleViewController ?? nav)
        } else if let tab = root as? UITabBarController {
            return topViewController(for: tab.selectedViewController ?? tab)
        } else {
            return root
        }
    }
}
