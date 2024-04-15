//
//  ProfileInfoRowCommonView.swift
//  SpendSmart
//
//  Created by dtrognn on 14/04/2024.
//

import SwiftUI

struct ProfileInfoRowCommonView: View {
    private var leftText: String
    private var rightText: String

    init(leftText: String, rightText: String) {
        self.leftText = leftText
        self.rightText = rightText
    }

    var body: some View {
        VStack(spacing: AppStyle.layout.zero) {
            HStack(spacing: AppStyle.layout.zero) {
                leftTextView
                Spacer()
                rightTextView
            }.padding(.all, AppStyle.layout.standardSpace)
            StraightLine()
        }
    }
}

private extension ProfileInfoRowCommonView {
    var leftTextView: some View {
        return Text(leftText)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNoteColor)
    }

    var rightTextView: some View {
        return Text(rightText)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
