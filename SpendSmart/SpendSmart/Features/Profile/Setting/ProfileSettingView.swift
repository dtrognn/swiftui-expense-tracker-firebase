//
//  ProfileSettingView.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

struct ProfileSettingView: View {
    @EnvironmentObject private var router: ProfileSettingRouter
    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Profile_Setting_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppStyle.layout.standardSpace) {
                    languageRowView
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension ProfileSettingView {
    var languageRowView: some View {
        return ProfileSettingRowView(title: language("Profile_Setting_A_02")) {
            router.push(to: .language)
        }
    }
}
