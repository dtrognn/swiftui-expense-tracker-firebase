//
//  SelectTransTypeView.swift
//  SpendSmart
//
//  Created by dtrognn on 25/04/2024.
//

import SwiftUI

struct SelectTransTypeView: View {
    @Binding private var type: TransactionType
    private var onSelect: ((TransactionType) -> Void)?

    init(type: Binding<TransactionType>, onSelect: ((TransactionType) -> Void)? = nil) {
        self._type = type
        self.onSelect = onSelect
    }

    var body: some View {
        HStack(spacing: AppStyle.layout.zero) {
            expenseButton
            incomeButton
        }.frame(maxWidth: UIScreen.main.bounds.size.width / 2)
    }
}

private extension SelectTransTypeView {
    var expenseButton: some View {
        return Button {
            withAnimation(.smooth) {
                type = .expense
            }
        } label: {
            VStack(spacing: AppStyle.layout.mediumSpace) {
                expenseText
                expenseStraightLine
            }
        }
    }

    var incomeButton: some View {
        return Button {
            withAnimation(.smooth) {
                type = .income
            }
        } label: {
            VStack(spacing: AppStyle.layout.mediumSpace) {
                incomeText
                incomeStraightLine
            }
        }
    }

    var expenseText: some View {
        return Text(language("SS_Common_A_11"))
            .font(type == .expense ? AppStyle.font.bold20 : AppStyle.font.semibold20)
            .foregroundColor(type == .expense ? AppStyle.theme.textHightlightColor : AppStyle.theme.textNormalColor)
    }

    var expenseStraightLine: some View {
        return GeometryReader { proxy in
            Divider()
                .font(AppStyle.font.semibold16)
                .frame(width: proxy.size.width, height: 5)
                .background(type == .expense ? AppStyle.theme.textHightlightColor : AppStyle.theme.textNoteColor)
        }
    }

    var incomeText: some View {
        return Text(language("SS_Common_A_12"))
            .font(type == .income ? AppStyle.font.bold20 : AppStyle.font.semibold20)
            .foregroundColor(type == .income ? AppStyle.theme.textHightlightColor : AppStyle.theme.textNormalColor)
    }

    var incomeStraightLine: some View {
        return GeometryReader { proxy in
            Divider()
                .font(AppStyle.font.semibold16)
                .frame(width: proxy.size.width, height: 5)
                .background(type == .income ? AppStyle.theme.textHightlightColor : AppStyle.theme.textNoteColor)
        }
    }
}
