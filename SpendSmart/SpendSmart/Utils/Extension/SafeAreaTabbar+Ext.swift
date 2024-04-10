//
//  SafeAreaTabbar+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 10/04/2024.
//

import SwiftUI

public extension UITabBarController {
    var height: CGFloat {
        return self.tabBar.frame.size.height
    }

    var width: CGFloat {
        return self.tabBar.frame.size.width
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUIInsets ?? EdgeInsets()
    }
}

private extension UIEdgeInsets {
    var swiftUIInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

public extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsEnvironmentKey.self]
    }
}
