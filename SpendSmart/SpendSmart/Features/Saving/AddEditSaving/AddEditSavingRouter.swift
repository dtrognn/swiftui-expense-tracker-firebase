//
//  AddEditSavingRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

class AddEditSavingRouter: BaseRouter<AddEditSavingRouter.Screen> {
    enum Screen: IScreen {
        case categoryList(CategoryActionType)
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .categoryList(let actionType):
            let router = CategoryListRouter(navigationPath: navigationPath)
            return CategoryListRouterView(router: router, actionType: actionType, onSelect: { category in
                AddEditSavingVM.shared.updateCategory(category)
                self.popView()
            }).asAnyView
        }
    }
}

struct AddEditSavingRouterView: View {
    @StateObject private var router: AddEditSavingRouter

    init(router: AddEditSavingRouter, saving: Saving? = nil) {
        self._router = StateObject(wrappedValue: router)
        AddEditSavingVM.shared.setParams(saving)
    }

    var body: some View {
        return AddEditSavingView()
            .environmentObject(router)
    }
}
