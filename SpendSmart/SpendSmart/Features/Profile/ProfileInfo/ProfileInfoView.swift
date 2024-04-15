//
//  ProfileInfoView.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import SwiftUI

struct ProfileInfoView: View {
    @EnvironmentObject private var router: ProfileRouter
    @StateObject private var vm = ProfileInfoVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Profile_Info_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.zero) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppStyle.layout.largeSpace) {
                        avatarView()

                        VStack(spacing: AppStyle.layout.zero) {
                            fullnameRowView
                            emailRowView
                            dateCreatedRowView
                            phoneNumberRowView
                            addressRowView
                        }.applyShadowView()
                    }.padding(.vertical, AppStyle.layout.standardSpace)
                }

                Spacer()
                editInfoButton
                    .padding(.bottom, AppStyle.layout.standardButtonHeight)
                    .padding(.horizontal, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension ProfileInfoView {
    @ViewBuilder
    func avatarView() -> some View {
        if vm.avatarUrl.isEmpty {
            UserAvararDefaultView(width: 90, height: 90).asAnyView
        } else {
            ImageUrl(configuration: ImageConfiguration(urlString: vm.avatarUrl), contentMode: .fit) {
                ProgressView()
            }.frame(width: 90, height: 90)
                .clipShape(Circle())
                .overlay(Circle().stroke(AppStyle.theme.iconColor, lineWidth: 1))
        }
    }

    var fullnameRowView: some View {
        return ProfileInfoRowCommonView(leftText: language("Profile_Info_A_03"), rightText: vm.fullname)
    }

    var emailRowView: some View {
        return ProfileInfoRowCommonView(leftText: language("Profile_Info_A_02"), rightText: vm.email)
    }

    var dateCreatedRowView: some View {
        return ProfileInfoRowCommonView(leftText: language("Profile_Info_A_05"), rightText: vm.dateCreated)
    }

    var phoneNumberRowView: some View {
        return ProfileInfoRowCommonView(leftText: language("Profile_Info_A_04"), rightText: vm.phoneNumber)
    }

    var addressRowView: some View {
        return ProfileInfoRowCommonView(leftText: language("Profile_Info_A_06"), rightText: vm.address)
    }

    var editInfoButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.push(to: .editProfile(vm.user))
        } label: {
            Text(language("Profile_Info_A_07"))
        }.buttonStyle(.standard())
    }
}
