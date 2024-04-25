//
//  SearchRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class AnalyticsRouter: BaseRouter<AnalyticsRouter.Screen> {
    enum Screen: IScreen {}

    override func getInstanceScreen(_ screen: Screen) -> AnyView {}
}

struct AnalyticsRouterView: View {
    @StateObject private var router = AnalyticsRouter()

    var body: some View {
        SSNavigationStackView(navigationPath: router.navigationPath) {
            AnalyticsView()
        }.environmentObject(router)
    }
}
