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
}
