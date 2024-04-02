//
//  ConfigureTextFieldStyle.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct ConfigureTextFieldStyle: TextFieldStyle {
    public var configurationData: TextFieldStyleConfiguration

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(configurationData.textColor)
            .font(configurationData.textFont)
            .padding(configurationData.padding)
            .background(
                RoundedRectangle(
                    cornerRadius: configurationData.cornerRadius,
                    style: .continuous)
                    .stroke(
                        configurationData.boderConfiguration?.boderColor ?? .clear,
                        lineWidth: configurationData.boderConfiguration?.borderWidth ?? 0)
            )
    }
}

extension TextFieldStyle where Self == ConfigureTextFieldStyle {
    static func standard() -> Self {
        let configurationData = TextFieldStyleConfiguration(
            textColor: AppStyle.theme.textNormalColor,
            textFont: AppStyle.font.regular16,
            padding: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
            cornerRadius: 0,
            boderConfiguration: nil)

        return Self(configurationData: configurationData)
    }

    static func custom(_ configurationData: TextFieldStyleConfiguration) -> Self {
        return Self(configurationData: configurationData)
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
