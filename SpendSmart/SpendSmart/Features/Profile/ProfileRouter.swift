//
//  ProfileRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class ProfileRouter: BaseRouter<ProfileRouter.Screen> {
    enum Screen: IScreen {
        case profileInfo
        case editProfile(User)
        case categoryList(CategoryActionType)
        case setting
    }

    override func getInstanceScreen(_ screen: Screen) -> AnyView {
        switch screen {
        case .profileInfo:
            return ProfileInfoView().environmentObject(self).asAnyView
        case .editProfile(let user):
            return ProfileEditInfoView(user).environmentObject(self).asAnyView
        case .categoryList(let actionType):
            let router = CategoryListRouter(navigationPath: navigationPath)
            return CategoryListRouterView(router: router, actionType: actionType).asAnyView
        case .setting:
            let router = ProfileSettingRouter(navigationPath: navigationPath)
            return ProfileSettingRouterView(router).asAnyView
        }
    }
}

struct ProfileRouterView: View {
    @StateObject private var router = ProfileRouter()

    var body: some View {
        SSNavigationStackView(navigationPath: router.navigationPath) {
            ProfileView()
        }.environmentObject(router)
    }
}
