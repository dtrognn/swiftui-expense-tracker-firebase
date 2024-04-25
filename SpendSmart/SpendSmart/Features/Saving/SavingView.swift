//
//  SavingView.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

struct SavingView: View {
    @EnvironmentObject private var router: SavingRouter
    @StateObject private var vm = SavingVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Saving_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true,
            showNaviUnderline: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.standardSpace) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        if vm.savings.isEmpty {
                            noSavingsView
                        } else {
                            LazyVStack(spacing: AppStyle.layout.standardSpace) {
                                ForEach(vm.savings) { saving in
                                    SavingItemView(saving: saving) { savingSelected in
                                        router.push(to: .addEditSaving(savingSelected))
                                    }
                                }
                            }
                        }
                    }.padding(.all, AppStyle.layout.standardSpace)
                }

                Spacer()
                if !vm.savings.isEmpty {
                    addNewSavingLargeButton
                        .padding(.horizontal, AppStyle.layout.standardSpace)
                        .padding(.bottom, AppStyle.layout.standardButtonHeight)
                }
            }
        }
    }
}

private extension SavingView {
    var noSavingsView: some View {
        return VStack(spacing: AppStyle.layout.mediumSpace) {
            noSavingsText
            addNewSavingSmalButton
        }.padding(.top, AppStyle.layout.standardButtonHeight)
    }

    var addNewSavingSmalButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.push(to: .addEditSaving(nil))
        } label: {
            Text(language("Saving_A_03"))
                .font(AppStyle.font.regular16)
                .foregroundColor(AppStyle.theme.btTextEnableColor)
                .padding(.vertical, AppStyle.layout.smallSpace)
                .padding(.horizontal, AppStyle.layout.mediumSpace)
                .background(AppStyle.theme.btBackgroundEnableColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
        }
    }

    var addNewSavingLargeButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.push(to: .addEditSaving(nil))
        } label: {
            Text(language("Saving_A_03"))
        }.buttonStyle(.standard())
    }

    var noSavingsText: some View {
        return Text(language("Saving_A_02"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
