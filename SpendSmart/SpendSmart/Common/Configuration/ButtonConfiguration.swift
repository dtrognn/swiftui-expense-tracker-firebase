//
//  ButtonConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

struct ButtonConfiguration {
    var height: CGFloat
    var textColor: Color
    var textFont: Font
    var backgroundColor: Color
    var cornerRadius: Double
    var isDisabled: Bool = false
    var padding: EdgeInsets?

    var boderConfiguration: BoderConfiguration?
    var shadowConfiguration: ShadowConfiguration?
}

struct ConfigButtonStyle: ButtonStyle {
    var configurationData: ButtonConfiguration

    func makeBody(configuration: Self.Configuration) -> some View {
        return checkData(configuration: configuration)
            .font(configurationData.textFont)
            .foregroundColor(configurationData.textColor)
            .background(
                RoundedRectangle(
                    cornerRadius: configurationData.cornerRadius)
                    .strokeBorder(configurationData.boderConfiguration?.boderColor ?? .white, lineWidth: configurationData.boderConfiguration?.borderWidth ?? 0)
                    .background(
                        RoundedRectangle(cornerRadius: configurationData.cornerRadius)
                            .fill(configuration.isPressed ? configurationData.backgroundColor.opacity(0.5) : configurationData.backgroundColor))
                    .shadow(
                        color: configurationData.shadowConfiguration?.shadowColor ?? .clear,
                        radius: configurationData.shadowConfiguration?.shadowRadius ?? 0,
                        x: configurationData.shadowConfiguration?.shadowX ?? 0,
                        y: configurationData.shadowConfiguration?.shadowY ?? 0)
            ).allowsHitTesting(!configurationData.isDisabled)
    }

    func checkData(configuration: Self.Configuration) -> some View {
        if let padding = configurationData.padding {
            return configuration.label
                .padding(padding)
                .asAnyView
        } else {
            return configuration.label
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: configurationData.height)
                .asAnyView
        }
    }
}
