//
//  ProfileSettingView.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

struct ProfileSettingView: View {
    @EnvironmentObject private var router: ProfileSettingRouter
    @StateObject private var vm = ProfileSettingVM()

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
//                    darkModeRowView
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

    var darkModeRowView: some View {
        return SettingDarkModeRowView(title: language("Profile_Setting_A_03"), value: $vm.isDarkMode) { isOn in
            vm.handleChangeDarkMode(isOn)
        }
    }
}
