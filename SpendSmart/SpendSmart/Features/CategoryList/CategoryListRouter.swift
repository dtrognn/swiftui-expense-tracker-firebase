//
//  CategoryListRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

class CategoryListRouter: BaseRouter<CategoryListRouter.Screen> {
    enum Screen: IScreen {
        case addEditCategory(Category?)
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .addEditCategory(let category):
            let router = AddEditCategoryRouter(navigationPath: navigationPath)
            return AddEditCategoryRouterView(router: router, category: category).asAnyView
        }
    }
}

struct CategoryListRouterView: View {
    @StateObject private var router: CategoryListRouter
    private var actionType: CategoryActionType
    private var onSelect: ((Category) -> Void)?

    init(router: CategoryListRouter, actionType: CategoryActionType, onSelect: ((Category) -> Void)? = nil) {
        self._router = StateObject(wrappedValue: router)
        self.actionType = actionType
        self.onSelect = onSelect
    }

    var body: some View {
        CategoryListView(actionType, onSelect: onSelect)
            .environmentObject(router)
    }
}
