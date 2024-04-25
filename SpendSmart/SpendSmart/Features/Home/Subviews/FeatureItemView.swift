//
//  FeatureItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

struct FeatureItemView: View {
    private var feature: Feature
    private var onClick: ((Feature) -> Void)?

    private let circleWidth: CGFloat = 30.0

    init(_ feature: Feature, onClick: ((Feature) -> Void)? = nil) {
        self.feature = feature
        self.onClick = onClick
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onClick?(feature)
        } label: {
            VStack(spacing: AppStyle.layout.mediumSpace) {
                iconImage
                titleText
            }.padding(.all, AppStyle.layout.smallSpace)
        }
    }
}

private extension FeatureItemView {
    var titleText: some View {
        return Text(feature.title)
            .font(AppStyle.font.regular12)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var iconImage: some View {
        return feature.icon
            .resizable()
            .applyTheme()
            .frame(width: circleWidth, height: circleWidth)
    }
}
