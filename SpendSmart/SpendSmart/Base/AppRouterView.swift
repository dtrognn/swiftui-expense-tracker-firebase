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
    private let appDataManager = AppDataManager.shared

    override init() {
        super.init()
        self.screen = .appLaunch
    }

    override func makeSubscription() {
        self.appDataManager.appState.loginState.$loggedIn.sink { [weak self] isLogin in
            self?.updateScreen(isLogin: isLogin)
        }.store(in: &cancellableSet)
    }

    private func updateScreen(isLogin: Bool) {
        if isLogin == true {
            self.screen = .mainTab
        } else {
            self.screen = .login
        }
        popToRootView()
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

    init(router: AppRouter = .init()) {
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        SSNavigationStackView(navigationPath: self.router.navigationPath) {
            self.router.getInstanceScreen(self.router.screen)
        }.environmentObject(self.router)
    }
}
