//
//  SplashScreenView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        ZStack {
            AppStyle.theme.splashBackgroundColor

            LogoAppView()
        }.ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    nextScreen()
                }
            }
    }

    func nextScreen() {
        if AppDataManager.shared.isLogout {
            router.push(to: .login)
        } else {
            router.push(to: .mainTab)
        }
    }
}

#Preview {
    SplashScreenView()
}
