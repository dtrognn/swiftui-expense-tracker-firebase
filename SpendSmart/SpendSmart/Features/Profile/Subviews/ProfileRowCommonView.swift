//
//  ProfileRowCommonView.swift
//  SpendSmart
//
//  Created by dtrognn on 12/04/2024.
//

import SwiftUI

struct ProfileRowCommonView: View {
    private var image: Image
    private var themeImage: Color
    private var title: String
    private var showUnderline: Bool
    private var onClick: (() -> Void)?

    init(image: Image, themeImage: Color = AppStyle.theme.iconColor, title: String, showUnderline: Bool = true, onClick: (() -> Void)? = nil) {
        self.image = image
        self.themeImage = themeImage
        self.title = title
        self.showUnderline = showUnderline
        self.onClick = onClick
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onClick?()
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.zero) {
                    HStack(spacing: AppStyle.layout.standardSpace) {
                        leftImage
                        titleText
                    }
                    Spacer()
                    arrowImage
                }.padding(.all, AppStyle.layout.standardSpace)

                if showUnderline {
                    StraightLine()
                }
            }
        }
    }
}

private extension ProfileRowCommonView {
    var leftImage: some View {
        return image
            .resizable()
            .applyTheme(themeImage)
            .frame(width: 20, height: 20)
    }

    var titleText: some View {
        return Text(title)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var arrowImage: some View {
        return Image("ic_arrow_right").applyTheme()
    }
}
