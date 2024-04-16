//
//  ProfileSettingRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

class ProfileSettingRouter: BaseRouter<ProfileSettingRouter.Screen> {
    enum Screen: IScreen {
        case language
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .language:
            return ChangeLanguageView().environmentObject(self).asAnyView
        }
    }
}

struct ProfileSettingRouterView: View {
    @StateObject private var router: ProfileSettingRouter

    init(_ router: ProfileSettingRouter) {
        self._router = StateObject(wrappedValue: router)
    }

    var body: some View {
        ProfileSettingView()
            .environmentObject(router)
    }
}
