//
//  SavingRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

class SavingRouter: BaseRouter<SavingRouter.Screen> {
    enum Screen: IScreen {
        case addEditSaving(Saving?)
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .addEditSaving(let saving):
            let router = AddEditSavingRouter(navigationPath: navigationPath)
            return AddEditSavingRouterView(router: router, saving: saving).asAnyView
        }
    }
}

struct SavingRouterView: View {
    @StateObject private var router: SavingRouter

    init(_ router: SavingRouter) {
        self._router = StateObject(wrappedValue: router)
    }

    var body: some View {
        SavingView()
            .environmentObject(router)
    }
}
