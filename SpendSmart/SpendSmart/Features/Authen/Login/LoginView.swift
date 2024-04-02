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
                VStack {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        emailTextFieldView
                        passwordTextFieldView
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension LoginView {
    var emailTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.email,
            placeHolder: "Enter your email",
            titleName: "Email"
        ))
    }

    var passwordTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.password,
            placeHolder: "Enter your password",
            titleName: "Password",
            isSecure: true
        ))
    }
}
