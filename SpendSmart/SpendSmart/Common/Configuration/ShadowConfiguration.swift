//
//  ShadowConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

struct ShadowConfiguration {
    var shadowRadius: Double
    var shadowColor: Color
    var shadowX: Double
    var shadowY: Double

    init() {
        shadowRadius = 5.0
        shadowColor = AppStyle.theme.shadowColor
        shadowX = 0
        shadowY = 3
    }

    init(shadowRadius: Double, shadowColor: Color, shadowX: Double, shadowY: Double) {
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.shadowX = shadowX
        self.shadowY = shadowY
    }
}
