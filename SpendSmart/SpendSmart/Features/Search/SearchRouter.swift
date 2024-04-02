//
//  SearchRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class SearchRouter: BaseRouter<SearchRouter.Screen> {
    enum Screen: IScreen {}

    override func getInstanceScreen(_ screen: Screen) -> AnyView {}
}

struct SearchRouterView: View {
    @StateObject private var router = SearchRouter()

    var body: some View {
        SSNavigationStackView(navigationPath: router.navigationPath) {
            SearchView()
        }.environmentObject(router)
    }
}
