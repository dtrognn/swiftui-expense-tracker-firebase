//
//  RegisterView.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegisterVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: "Create account",
            showBackButton: true,
            showNavibar: true,
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
                        fullnameTextFieldView
                        registerButton
                    }
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
            Text("Register")
        }.buttonStyle(.standard())
    }

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

    var fullnameTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.fullname,
            placeHolder: "Enter your fullname",
            titleName: "Fullname",
            isSecure: true
        ))
    }
}
