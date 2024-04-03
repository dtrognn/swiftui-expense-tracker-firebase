//
//  LoginRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class LoginRouter: BaseRouter<LoginRouter.Screen> {
    enum Screen: IScreen {
        case register
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .register:
            return RegisterView().environmentObject(self).asAnyView
        }
    }
}

struct LoginRouterView: View {
    @StateObject private var router = LoginRouter()

    var body: some View {
        SSNavigationStackView(navigationPath: router.navigationPath) {
            LoginView()
        }.environmentObject(router)
    }
}
