//
//  AddEditTransactionRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import SwiftUI

class AddEditTransactionRouter: BaseRouter<AddEditTransactionRouter.Screen> {
    enum Screen: IScreen {
        case categoryList
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .categoryList:
            let router = CategoryListRouter(navigationPath: navigationPath)
            return CategoryListRouterView(router: router).asAnyView
        }
    }
}

struct AddEditTransactionRouterView: View {
    @StateObject private var router: AddEditTransactionRouter
    private var transaction: Transaction?

    init(router: AddEditTransactionRouter, transaction: Transaction? = nil) {
        self._router = StateObject(wrappedValue: router)
        self.transaction = transaction
    }

    var body: some View {
        AddEditTransactionView(transaction)
            .environmentObject(router)
    }
}
