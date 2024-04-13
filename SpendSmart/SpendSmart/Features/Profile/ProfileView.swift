//
//  ProfileView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var router: ProfileRouter
    @StateObject private var vm = ProfileVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: "",
            showBackButton: false,
            showNavibar: false,
            hidesBottomBarWhenPushed: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppStyle.layout.largeSpace) {
                    userInfoView

                    Group {
                        VStack(spacing: AppStyle.layout.zero) {
                            profileInfoRowView
                            categoryManageRowView
                        }
                    }.applyShadowView()

                    logoutRowView
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension ProfileView {
    var userInfoView: some View {
        return HStack(spacing: AppStyle.layout.standardSpace) {
            userImage
            VStack(alignment: .leading, spacing: AppStyle.layout.mediumSpace) {
                userNameText
                emailText
            }
            Spacer()
        }
    }

    var userNameText: some View {
        return Text(vm.userName)
            .font(AppStyle.font.medium16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var userImage: some View {
        return Image(systemName: "person.crop.circle")
            .resizable()
            .applyTheme()
            .frame(width: 50, height: 50)
    }

    var emailText: some View {
        return Text(vm.email)
            .font(AppStyle.font.regular14)
            .foregroundColor(AppStyle.theme.textNoteColor)
    }

    var profileInfoRowView: some View {
        return ProfileRowCommonView(image: .init(systemName: "person"), title: language("Profile_A_01")) {
            // TODO: -
        }
    }

    var categoryManageRowView: some View {
        return ProfileRowCommonView(image: .init(systemName: "folder"), title: language("Profile_A_02")) {
            router.push(to: .categoryList(.update))
        }
    }

    var logoutRowView: some View {
        return ProfileRowCommonView(image: .init("ic_logout"), title: language("Profile_A_03"), showUnderline: false) {
            vm.signOut()
        }.applyShadowView()
    }
}
