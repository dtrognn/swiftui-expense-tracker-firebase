//
//  HomeRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class HomeRouter: BaseRouter<HomeRouter.Screen> {
    enum Screen: IScreen {
        case addNewCategory
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .addNewCategory:
            return AddNewCategoryView().environmentObject(self).asAnyView
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
