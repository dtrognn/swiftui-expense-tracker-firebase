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
        case addNewCategory(Category?)
        case recentTransaction
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .addEditTransaction(let transaction):
            let router = AddEditTransactionRouter(navigationPath: navigationPath)
            return AddEditTransactionRouterView(router: router, transaction: transaction).asAnyView
        case .addNewCategory(let category):
            let router = AddEditCategoryRouter(navigationPath: navigationPath)
            return AddEditCategoryRouterView(router: router, category: category).asAnyView
        case .recentTransaction:
            let router = RecentTransactionsRouter(navigationPath: navigationPath)
            return RecentTransactionsRouterView(router: router).asAnyView
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
