//
//  UserAvararView.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import SwiftUI

struct UserAvararDefaultView: View {
    private let circleWidth: CGFloat = 50.0

    var body: some View {
        Image(systemName: "person.crop.circle")
            .resizable()
            .applyTheme()
            .frame(width: circleWidth, height: circleWidth)
            .overlay(Circle().stroke(AppStyle.theme.iconColor, lineWidth: 1))
    }
}
