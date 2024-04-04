//
//  RegisterView.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var router: LoginRouter
    @StateObject private var vm = RegisterVM()
    @State private var isSlectCheckbox: Bool = false

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Register_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: false
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppStyle.layout.zero) {
                    logoAppView
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        fullnameTextFieldView
                        emailTextFieldView
                        passwordTextFieldView
                    }
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        registerButton
                        signInView
                    }.padding(.top, AppStyle.layout.largeSpace)
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension RegisterView {
    var registerButton: some View {
        return Button {
            vm.register()
        } label: {
            Text(language("Register_A_08"))
        }.buttonStyle(.standard(isActive: vm.isEnableButton))
    }

    var signInView: some View {
        return HStack(alignment: .center, spacing: AppStyle.layout.smallSpace) {
            alreadyHaveAccountText
            signInButton
        }
    }

    var signInButton: some View {
        return Button {
            router.popView()
        } label: {
            Text(language("Register_A_10"))
                .font(AppStyle.font.semibold16)
                .foregroundColor(AppStyle.theme.textUnderlineColor)
                .underline(color: AppStyle.theme.textUnderlineColor)
                .padding([.vertical, .trailing], AppStyle.layout.smallSpace)
        }
    }

    var termsView: some View {
        return HStack {
            cbTerms
        }
    }

    var cbTerms: some View {
        return Button {
            isSlectCheckbox.toggle()
        } label: {
            Image(systemName: isSlectCheckbox ? "checkmark.square" : "square")
                .applyTheme(AppStyle.theme.iconColor)
                .padding(.all, AppStyle.layout.smallSpace)
        }
    }

    var emailTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.email,
            placeHolder: language("Register_A_04"),
            titleName: language("Register_A_05"),
            errorMessage: language("Register_A_11"),
            showErrorMessage: $vm.showEmailError
        ))
    }

    var passwordTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.password,
            placeHolder: language("Register_A_06"),
            titleName: language("Register_A_07"),
            errorMessage: language("Register_A_12"),
            showErrorMessage: $vm.showPasswordError,
            isSecure: true
        ))
    }

    var fullnameTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.fullname,
            placeHolder: language("Register_A_02"),
            titleName: language("Register_A_03")
        ))
    }

    var logoAppView: some View {
        return LogoAppView()
    }

    var alreadyHaveAccountText: some View {
        return Text(language("Register_A_09"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNoteColor)
    }
}
