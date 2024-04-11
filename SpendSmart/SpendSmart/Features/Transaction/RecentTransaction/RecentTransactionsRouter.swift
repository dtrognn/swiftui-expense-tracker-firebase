//
//  RecentTransactionsRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 11/04/2024.
//

import SwiftUI

class RecentTransactionsRouter: BaseRouter<RecentTransactionsRouter.Screen> {
    enum Screen: IScreen {
        case addEditTransaction(Transaction?)
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .addEditTransaction(let transaction):
            let router = AddEditTransactionRouter(navigationPath: navigationPath)
            return AddEditTransactionRouterView(router: router, transaction: transaction).asAnyView
        }
    }
}

struct RecentTransactionsRouterView: View {
    @StateObject private var router: RecentTransactionsRouter

    init(router: RecentTransactionsRouter) {
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        RecentTransactionsView()
            .environmentObject(router)
    }
}
