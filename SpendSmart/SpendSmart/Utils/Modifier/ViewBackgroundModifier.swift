//
//  ViewBackgroundModifier.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct ViewModifierBackground: ViewModifier {
    var colorFill: Color
    var cornerRadius: CGFloat
    var shadowConfiguration: ShadowConfiguration

    func body(content: Content) -> some View {
        content.background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(colorFill)
                .shadow(color: shadowConfiguration.shadowColor,
                        radius: shadowConfiguration.shadowRadius)
        )
    }
}
