//
//  AppRouterView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class AppRouter: BaseRouter<AppRouter.Screen> {
    enum Screen: IScreen {
        case appLaunch
        case login
        case mainTab
    }

    @Published var screen: Screen = .appLaunch

    override init() {
        super.init()
        self.screen = .appLaunch
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .appLaunch:
            return SplashScreenView().asAnyView
        case .login:
            return LoginRouterView().asAnyView
        case .mainTab:
            return TabbarRouterView().asAnyView
        }
    }
}

struct AppRouterView: View {
    @StateObject private var router: AppRouter = .init()

    var body: some View {
        SSNavigationStackView(navigationPath: router.navigationPath) {
            router.getInstanceScreen(router.screen)
        }.environmentObject(router)
    }
}
