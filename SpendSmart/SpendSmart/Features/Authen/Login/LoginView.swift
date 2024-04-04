//
//  LoginView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var router: LoginRouter
    @StateObject private var vm = LoginVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: "",
            showBackButton: false,
            showNavibar: false,
            hidesBottomBarWhenPushed: false
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppStyle.layout.zero) {
                    logoAppView
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        emailTextFieldView
                        passwordTextFieldView
                    }

                    HStack(spacing: AppStyle.layout.zero) {
                        rememberPassView
                        Spacer()
                        forgotPassButton
                    }.padding(.top, AppStyle.layout.mediumSpace)

                    VStack(spacing: AppStyle.layout.standardSpace) {
                        loginButton
                        registerView
                    }.padding(.top, AppStyle.layout.largeSpace)
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension LoginView {
    var loginButton: some View {
        return Button {
            vm.signIn()
        } label: {
            Text(language("Login_A_01"))
        }.buttonStyle(.standard(isActive: vm.isEnableButton))
    }

    var registerView: some View {
        return HStack(alignment: .center, spacing: AppStyle.layout.smallSpace) {
            dontHaveAccountText
            signUpButton
        }
    }

    var forgotPassButton: some View {
        return Button {
            // TODO: -
        } label: {
            Text("Login_A_06")
                .font(AppStyle.font.regular16)
                .foregroundColor(AppStyle.theme.textHightlightColor)
                .padding(.vertical, AppStyle.layout.smallSpace)
        }
    }

    var rememberPassView: some View {
        return HStack(alignment: .center, spacing: AppStyle.layout.zero) {
            cbRememberView
            rememberPassText
        }
    }

    var cbRememberView: some View {
        return Button {
            vm.isRememberPassword.toggle()
        } label: {
            Image(systemName: vm.isRememberPassword ? "checkmark.square" : "square")
                .applyTheme(AppStyle.theme.iconColor)
                .padding(.all, AppStyle.layout.smallSpace)
        }
    }

    var emailTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.email,
            placeHolder: language("Login_A_02"),
            titleName: language("Login_A_03")
        ))
    }

    var passwordTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.password,
            placeHolder: language("Login_A_04"),
            titleName: language("Login_A_05"),
            isSecure: true
        ))
    }

    var signUpButton: some View {
        return Button {
            router.push(to: .register)
        } label: {
            Text(language("Login_A_09"))
                .font(AppStyle.font.semibold16)
                .foregroundColor(AppStyle.theme.textUnderlineColor)
                .underline(color: AppStyle.theme.textUnderlineColor)
                .padding([.vertical, .trailing], AppStyle.layout.smallSpace)
        }
    }

    var dontHaveAccountText: some View {
        return Text(language("Login_A_08"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNoteColor)
    }

    var rememberPassText: some View {
        return Text(language("Login_A_07"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textHightlightColor)
    }

    var logoAppView: some View {
        return LogoAppView()
    }
}
