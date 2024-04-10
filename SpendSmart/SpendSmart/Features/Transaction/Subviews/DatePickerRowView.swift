//
//  DatePickerRowView.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

struct DatePickerRowView: View {
    private var dateString: String
    private var onClick: (() -> Void)?

    init(dateString: String, onClick: (() -> Void)? = nil) {
        self.dateString = dateString
        self.onClick = onClick
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onClick?()
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.zero) {
                    titleText
                    Spacer()
                    HStack(spacing: AppStyle.layout.mediumSpace) {
                        dateText
                        arrowImage
                    }
                }.padding(.all)
            }.applyShadowView()
        }
    }
}

private extension DatePickerRowView {
    var titleText: some View {
        return Text(language("Add_Edit_Transaction_A_08"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var dateText: some View {
        return Text(dateString)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var arrowImage: some View {
        return Image("ic_arrow_right").applyTheme()
    }
}
