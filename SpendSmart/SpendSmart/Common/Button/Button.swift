//
//  Button.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

extension ButtonStyle where Self == ConfigButtonStyle {
    static func standard(isActive: Bool = true) -> Self {
        let configurationData = ButtonConfiguration(
            height: AppStyle.layout.standardButtonHeight,
            textColor: isActive ? AppStyle.theme.btTextEnableColor : AppStyle.theme.btTextDisableColor,
            textFont: AppStyle.font.medium17,
            backgroundColor: isActive ? AppStyle.theme.btBackgroundEnableColor : AppStyle.theme.btBackgroundDisableColor,
            cornerRadius: AppStyle.layout.standardCornerRadius,
            isDisabled: !isActive,
            padding: nil)

        return Self(configurationData: configurationData)
    }

    static func custom(isActive: Bool = true, textFont: Font, padding: EdgeInsets) -> Self {
        let configurationData = ButtonConfiguration(
            height: AppStyle.layout.standardButtonHeight,
            textColor: isActive ? AppStyle.theme.btTextEnableColor : AppStyle.theme.btTextDisableColor,
            textFont: textFont,
            backgroundColor: isActive ? AppStyle.theme.btBackgroundEnableColor : AppStyle.theme.btBackgroundDisableColor,
            cornerRadius: AppStyle.layout.standardCornerRadius,
            isDisabled: !isActive,
            padding: padding)

        return Self(configurationData: configurationData)
    }
}
