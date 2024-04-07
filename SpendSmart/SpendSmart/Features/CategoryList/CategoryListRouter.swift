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
            return AddEditCategoryView(category).environmentObject(self).asAnyView
        }
    }
}

struct CategoryListRouterView: View {
    @StateObject private var router: CategoryListRouter

    init(router: CategoryListRouter) {
        self._router = StateObject(wrappedValue: router)
    }

    var body: some View {
        CategoryListView()
            .environmentObject(router)
    }
}
