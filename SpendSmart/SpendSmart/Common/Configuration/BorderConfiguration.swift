//
//  BorderConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

public struct BoderConfiguration {
    public var borderWidth: CGFloat = 1
    public var boderColor: Color = .clear

    public init() {
        borderWidth = 1
        boderColor = .clear
    }

    public init(borderWidth: CGFloat, boderColor: Color) {
        self.borderWidth = borderWidth
        self.boderColor = boderColor
    }
}
