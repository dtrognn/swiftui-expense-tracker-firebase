//
//  SavingLogItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

struct SavingLogItemView: View {
    private var log: SavingLog

    init(_ log: SavingLog) {
        self.log = log
    }

    var body: some View {
        VStack(spacing: AppStyle.layout.zero) {
            HStack(spacing: AppStyle.layout.zero) {
                timeText
                Spacer()
                amountText
            }.padding(.vertical, AppStyle.layout.mediumSpace)
                .padding(.horizontal, AppStyle.layout.standardSpace)
            StraightLine()
        }.background(AppStyle.theme.rowCommonBackgroundColor)
    }
}

private extension SavingLogItemView {
    var timeText: some View {
        return Text(log.dateFormatted)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var amountText: some View {
        return Text(log.formattedAmount)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textHightlightColor)
    }
}
