//
//  Tabbar+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import UIKit

struct Tool {
    static func showTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach { v in
            if let view = v as? UITabBar {
                view.isHidden = false
            }
        }
    }

    static func hiddenTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach { v in
            if let view = v as? UITabBar {
                view.isHidden = true
            }
        }
    }
}
