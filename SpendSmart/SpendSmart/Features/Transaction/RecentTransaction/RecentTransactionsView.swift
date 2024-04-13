//
//  RecentTransactionsView.swift
//  SpendSmart
//
//  Created by dtrognn on 11/04/2024.
//

import SwiftUI

struct RecentTransactionsView: View {
    @EnvironmentObject private var router: RecentTransactionsRouter
    @StateObject private var vm = RecentTransactionsVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Recent_Transactions_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if vm.transactions.isEmpty {
                        noRecentTransView
                    } else {
                        LazyVStack(spacing: AppStyle.layout.standardSpace) {
                            ForEach(vm.transactions) { transaction in
                                TransactionItemView(transaction: transaction, onClick: { transactionSelected in
                                    router.push(to: .addEditTransaction(transactionSelected))
                                })
                                .applyShadowView()
                            }
                        }
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }.refreshable {
                vm.loadData()
            }
        }
    }
}

private extension RecentTransactionsView {
    var noRecentTransView: some View {
        return VStack(spacing: AppStyle.layout.standardSpace) {
            noRecentTransText
            addTransLargeButton
        }.padding(.top, AppStyle.layout.standardButtonHeight)
    }

    var addTransLargeButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.push(to: .addEditTransaction(nil))
        } label: {
            Text(language("Recent_Transactions_A_03"))
                .font(AppStyle.font.semibold16)
                .foregroundColor(AppStyle.theme.btTextEnableColor)
                .padding(.vertical, AppStyle.layout.mediumSpace)
                .padding(.horizontal, AppStyle.layout.standardSpace)
                .background(AppStyle.theme.btBackgroundEnableColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
        }
    }

    var noRecentTransText: some View {
        return Text(language("Recent_Transactions_A_02"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
