//
//  ProfileEditInfoView.swift
//  SpendSmart
//
//  Created by dtrognn on 14/04/2024.
//

import SwiftUI

struct ProfileEditInfoView: View {
    @EnvironmentObject private var router: ProfileRouter
    @StateObject private var vm: ProfileEditInfoVM

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Edit_Profile_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true)
    }

    init(_ user: User) {
        self._vm = StateObject(wrappedValue: ProfileEditInfoVM(user))
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.zero) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        emailTextFieldView
                        fullnameTextFieldView
                        phoneNumberTextFieldView
                        addressTextFieldView
                    }.padding(.all, AppStyle.layout.standardSpace)
                }

                Spacer()
                editInfoButton
                    .padding(.bottom, AppStyle.layout.standardButtonHeight)
                    .padding(.horizontal, AppStyle.layout.standardSpace)
            }
        }.onReceive(vm.onUpdateSuccess) { _ in
            router.popView()
        }
    }
}

private extension ProfileEditInfoView {
    var emailTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.email,
            placeHolder: language("Edit_Profile_A_02"),
            titleName: language("Edit_Profile_A_03"),
            isDisable: true))
    }

    var fullnameTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.fullname,
            placeHolder: language("Edit_Profile_A_04"),
            titleName: language("Edit_Profile_A_05")))
    }

    var phoneNumberTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.phoneNumber,
            placeHolder: language("Edit_Profile_A_06"),
            titleName: language("Edit_Profile_A_07")))
            .keyboardType(.numberPad)
    }

    var addressTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.address,
            placeHolder: language("Edit_Profile_A_08"),
            titleName: language("Edit_Profile_A_09")))
    }

    var editInfoButton: some View {
        return Button {
            Vibration.selection.vibrate()
            vm.updateUserInfo()
        } label: {
            Text(language("SS_Common_A_04"))
        }.buttonStyle(.standard())
    }
}
