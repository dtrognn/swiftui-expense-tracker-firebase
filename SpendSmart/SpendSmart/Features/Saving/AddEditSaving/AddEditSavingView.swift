//
//  AddEditSavingView.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

struct AddEditSavingView: View {
    @EnvironmentObject private var router: AddEditSavingRouter
    @StateObject private var vm = AddEditSavingVM.shared

    @State private var showAlert: Bool = false

    private var textEditorHeight: CGFloat = 70

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Saving_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.standardSpace) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        VStack(spacing: AppStyle.layout.standardSpace) {
                            amountTextField
                            descriptionTextEditorView
                            selectCategoryRowView
                        }
                        updateSavingsView
                    }.padding(.all, AppStyle.layout.standardSpace)
                }

                Spacer()
                HStack(spacing: AppStyle.layout.standardSpace) {
                    if vm.isEdit {
                        deleteButton
                    }
                    addEditSavingButton
                }.padding(.bottom, AppStyle.layout.standardButtonHeight)
                    .padding(.horizontal, AppStyle.layout.standardSpace)
            }
        }.onReceive(vm.onAddUpdateSuccess) { _ in
            router.popView()
        }.alertView(alerConfiguration)
    }
}

private extension AddEditSavingView {
    var amountTextField: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.amount,
            placeHolder: language("Add_Edit_Saving_A_03"),
            titleName: language("Add_Edit_Saving_A_04")
        )).keyboardType(.numberPad)
    }

    var descriptionTextEditorView: some View {
        return AutoHeightEditor(
            text: $vm.description,
            teHeight: textEditorHeight,
            maxLine: 5,
            hasBorder: true,
            isEnabled: .constant(true),
            disabledPlaceholder: language("Add_Edit_Saving_A_05"),
            regExpUse: .none
        ).frame(height: textEditorHeight)
    }

    var selectCategoryRowView: some View {
        return SelectCategoryRowView(category: vm.category) {
            router.push(to: .categoryList(.select))
        }
    }

    var addEditSavingButton: some View {
        return Button {
            Vibration.selection.vibrate()
            vm.addEditSavings()
        } label: {
            Text(language(vm.isEdit ? "SS_Common_A_04" : "SS_Common_A_03"))
        }.buttonStyle(.standard())
    }

    var deleteButton: some View {
        return Button {
            Vibration.selection.vibrate()
            showAlert = true
        } label: {
            Text(language("SS_Common_A_08"))
        }.buttonStyle(.standard())
    }

    var alerConfiguration: AlertConfiguration {
        return AlertConfiguration(
            isPresented: $showAlert,
            title: language("Add_Edit_Saving_A_12"),
            message: language("Add_Edit_Saving_A_13"),
            primaryButtonText: language("SS_Common_A_09"),
            secondaryButtonText: language("SS_Common_A_10")
        ) {} secondaryAction: {
            vm.deleteSaving()
        }
    }
}

private extension AddEditSavingView {
    var updateSavingsView: some View {
        return VStack(spacing: AppStyle.layout.standardSpace) {
            updateSavingsHeaderView
            if vm.isShowTextField {
                HStack(spacing: AppStyle.layout.standardSpace) {
                    moreLogTextField
                    addButton
                }
            }
            getLogListView()
        }
    }

    @ViewBuilder
    func getLogListView() -> some View {
        if vm.logs.isEmpty {
            noRecentUpdateText
        } else {
            LazyVStack(spacing: AppStyle.layout.zero) {
                ForEach(vm.logs) { log in
                    SavingLogItemView(log)
                }
            }.background(AppStyle.theme.rowCommonBackgroundColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
                .applyShadowView()
        }
    }

    var updateSavingsHeaderView: some View {
        return HStack(spacing: AppStyle.layout.zero) {
            updateSavingsText
            Spacer()
            addMoreSavingsButton
        }
    }

    var updateSavingsText: some View {
        return Text(language("Add_Edit_Saving_A_07"))
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var moreLogTextField: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.moreAmount,
            placeHolder: language("Add_Edit_Saving_A_10"),
            titleName: language("Add_Edit_Saving_A_11")
        )).keyboardType(.numberPad)
    }

    var addMoreSavingsButton: some View {
        return Button {
            vm.isShowTextField = true
        } label: {
            Text(language("Add_Edit_Saving_A_09"))
                .font(AppStyle.font.semibold16)
                .foregroundColor(AppStyle.theme.textHightlightColor)
        }
    }

    var addButton: some View {
        return Button {
            vm.addNewLog()
        } label: {
            Text(language("SS_Common_A_14"))
                .font(AppStyle.font.regular16)
                .foregroundColor(AppStyle.theme.btTextEnableColor)
                .padding(.vertical, AppStyle.layout.mediumSpace)
                .padding(.horizontal, AppStyle.layout.standardSpace)
                .background(AppStyle.theme.btBackgroundEnableColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
        }
    }

    var noRecentUpdateText: some View {
        return Text(language("Add_Edit_Saving_A_08"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
