//
//  ProfileRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

class ProfileRouter: BaseRouter<ProfileRouter.Screen> {
    enum Screen: IScreen {}

    override func getInstanceScreen(_ screen: Screen) -> AnyView {}
}

struct ProfileRouterView: View {
    @StateObject private var router = ProfileRouter()

    var body: some View {
        SSNavigationStackView(navigationPath: router.navigationPath) {
            ProfileView()
        }.environmentObject(router)
    }
}
