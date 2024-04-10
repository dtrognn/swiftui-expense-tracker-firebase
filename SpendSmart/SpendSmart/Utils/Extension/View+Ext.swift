//
//  View+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import SwiftUI

extension View {
    var asAnyView: AnyView {
        return AnyView(self)
    }

    func hidden(_ isHidden: Bool) -> some View {
        modifier(HiddenModifier(isHidden: isHidden))
    }

    func hiddenTabBar(_ isHidden: Bool) -> some View {
        if isHidden {
            return modifier(HiddenTabBar()).asAnyView
        } else {
            return modifier(ShowTabBar()).asAnyView
        }
    }

    func alertView(_ alertConfiguration: AlertConfiguration) -> some View {
        return alert(isPresented: alertConfiguration.isPresented) {
            Alert.alert(alertConfiguration)
        }
    }

    func applyShadowView(_ colorFill: Color = Color.white, cornerRadius: CGFloat = AppStyle.layout.standardCornerRadius) -> some View {
        modifier(ViewModifierBackground(colorFill: colorFill, cornerRadius: cornerRadius, shadowConfiguration: ShadowConfiguration()))
    }

    func show() {
        var window: UIWindow? {
            guard let scene = UIApplication.shared.connectedScenes.first,
                let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                let window = windowSceneDelegate.window else {
                return nil
            }
            return window
        }
        guard let window = window else { return }

        let hostingController = UIHostingController(rootView: self)
        hostingController.view.tag = (self as? IPopupView)?.tag ?? 100

        window.addSubview(hostingController.view)
        hostingController.view.frame = UIScreen.main.bounds
        hostingController.view.backgroundColor = .clear
    }

    func hide() {
        var window: UIWindow? {
            guard let scene = UIApplication.shared.connectedScenes.first,
                let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                let window = windowSceneDelegate.window else {
                return nil
            }
            return window
        }
        guard let window = window else { return }

        if let tag = (self as? IPopupView)?.tag {
            window.viewWithTag(tag)?.removeFromSuperview()
        }
    }
}
