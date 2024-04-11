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
                    LazyVStack(spacing: AppStyle.layout.standardSpace) {
                        ForEach(vm.transactions) { transaction in
                            TransactionItemView(transaction: transaction, onClick: { transactionSelected in
                                router.push(to: .addEditTransaction(transactionSelected))
                            })
                            .applyShadowView()
                        }
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }.refreshable {
                vm.loadData()
            }
        }
    }
}
