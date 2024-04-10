//
//  AddEditCategoryRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

class AddEditCategoryRouter: BaseRouter<AddEditCategoryRouter.Screen> {
    enum Screen: IScreen {}

    override func getInstanceScreen(_ screen: Screen) -> AnyView {}
}

struct AddEditCategoryRouterView: View {
    @StateObject private var router: AddEditCategoryRouter
    private var category: Category?

    init(router: AddEditCategoryRouter, category: Category? = nil) {
        self._router = StateObject(wrappedValue: router)
        self.category = category
    }

    var body: some View {
        return AddEditCategoryView(category)
            .environmentObject(router)
    }
}
