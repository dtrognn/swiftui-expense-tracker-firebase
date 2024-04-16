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
    @State private var image: UIImage?

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
                            changeLanguageRowView
                        }
                    }.applyShadowView()

                    logoutRowView
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }
    }
}

// MARK: - Profile info

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
        return UploadFileView {
            if vm.avatarUser.isEmpty {
                avatarDefault.asAnyView
            } else {
                avatarFromUrlView.asAnyView
            }
        } onImageResult: { image in
            vm.uploadImage(image)
        }.overlay(Circle().stroke(AppStyle.theme.iconColor, lineWidth: 1))
    }

    var emailText: some View {
        return Text(vm.email)
            .font(AppStyle.font.regular14)
            .foregroundColor(AppStyle.theme.textNoteColor)
    }

    var avatarDefault: some View {
        return UserAvararDefaultView(width: 50, height: 50)
    }

    var avatarFromUrlView: some View {
        return ImageUrl(configuration: ImageConfiguration(urlString: vm.avatarUser), contentMode: .fit) {
            ProgressView()
        }.frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

// MARK: -

private extension ProfileView {
    var profileInfoRowView: some View {
        return ProfileRowCommonView(image: .init("ic_profile_user"), title: language("Profile_A_01")) {
            router.push(to: .profileInfo)
        }
    }

    var categoryManageRowView: some View {
        return ProfileRowCommonView(image: .init("ic_profile_folder"), title: language("Profile_A_02")) {
            router.push(to: .categoryList(.update))
        }
    }

    var changeLanguageRowView: some View {
        return ProfileRowCommonView(image: .init("ic_profile_setting"), title: language("Profile_A_04")) {
            router.push(to: .changeLanguage)
        }
    }

    var logoutRowView: some View {
        return ProfileRowCommonView(image: .init("ic_logout"), title: language("Profile_A_03"), showUnderline: false) {
            vm.signOut()
        }.applyShadowView()
    }
}
