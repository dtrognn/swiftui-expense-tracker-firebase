//
//  TransactionItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 09/04/2024.
//

import SwiftUI

struct TransactionItemView: View {
    private var transaction: Transaction
    private var onClick: ((Transaction) -> Void)?

    private var backgroundWidth: CGFloat = 40.0
    private var iconWidth: CGFloat = 25.0

    init(transaction: Transaction, onClick: ((Transaction) -> Void)? = nil) {
        self.transaction = transaction
        self.onClick = onClick
    }

    var body: some View {
        Button {
            onClick?(transaction)
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.zero) {
                    HStack(spacing: AppStyle.layout.standardSpace) {
                        iconCategoryView
                        VStack(alignment: .leading, spacing: AppStyle.layout.mediumSpace) {
                            categoryNameText
                            dateText
                        }
                    }

                    Spacer()
                    amountText
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension TransactionItemView {
    var iconCategoryView: some View {
        return ZStack {
            backgroundCicle
            transaction.category.getIcon().image
                .frame(width: iconWidth, height: iconWidth)
        }
    }

    var backgroundCicle: some View {
        return Circle()
            .frame(width: backgroundWidth, height: backgroundWidth)
            .foregroundColor(transaction.category.getColor().color)
    }

    var categoryNameText: some View {
        return Text(transaction.category.name)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var amountText: some View {
//        return Text(String(format: "%.1f", transaction.amount))
        return Text(transaction.formattedAmount)
            .font(AppStyle.font.regular16)
            .foregroundColor(transaction.transactionType == .expense ? .red500 : AppStyle.theme.textHightlightColor)
    }

    var dateText: some View {
        return Text(UtilsHelper.doubleToDate(data: transaction.createdAt))
            .font(AppStyle.font.regular14)
            .foregroundColor(AppStyle.theme.textNoteColor)
    }
}
