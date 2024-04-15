//
//  UserAvararView.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import SwiftUI

struct UserAvararDefaultView: View {
    private let width: CGFloat
    private let height: CGFloat

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }

    var body: some View {
        Image(systemName: "person.crop.circle")
            .resizable()
            .applyTheme()
            .frame(width: width, height: height)
            .overlay(Circle().stroke(AppStyle.theme.iconColor, lineWidth: 1))
    }
}
