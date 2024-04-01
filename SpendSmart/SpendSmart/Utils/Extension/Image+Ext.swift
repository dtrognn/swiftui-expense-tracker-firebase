//
//  Image+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import SwiftUI

extension Image {
    func applyTheme(_ color: Color = AppStyle.theme.iconColor) -> some View {
        self.renderingMode(.template)
            .foregroundColor(color)
    }
}
