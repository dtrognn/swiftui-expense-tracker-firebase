//
//  AddEditTransactionRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import SwiftUI

class AddEditTransactionRouter: BaseRouter<AddEditTransactionRouter.Screen> {
    enum Screen: IScreen {}

    override func getInstanceScreen(_ screen: Screen) -> AnyView {}
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
