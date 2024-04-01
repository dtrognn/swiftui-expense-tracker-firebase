//
//  UIView+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import UIKit

extension UIView {
    func allSubviews() -> [UIView] {
        var res = self.subviews
        for subview in self.subviews {
            let riz = subview.allSubviews()
            res.append(contentsOf: riz)
        }
        return res
    }
}
