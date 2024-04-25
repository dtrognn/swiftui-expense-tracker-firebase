//
//  HomeRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class HomeRouter: BaseRouter<HomeRouter.Screen> {
    enum Screen: IScreen {
        case addEditTransaction(Transaction?)
        case recentTransaction
        case saving
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .addEditTransaction(let transaction):
            let router = AddEditTransactionRouter(navigationPath: navigationPath)
            return AddEditTransactionRouterView(router: router, transaction: transaction).asAnyView
        case .recentTransaction:
            let router = RecentTransactionsRouter(navigationPath: navigationPath)
            return RecentTransactionsRouterView(router: router).asAnyView
        case .saving:
            let router = SavingRouter(navigationPath: navigationPath)
            return SavingRouterView(router).asAnyView
        }
    }
}

struct HomeRouterView: View {
    @StateObject private var router = HomeRouter()

    var body: some View {
        SSNavigationStackView(navigationPath: router.navigationPath) {
            HomeView()
        }.environmentObject(router)
    }
}
