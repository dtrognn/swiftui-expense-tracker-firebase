//
//  AddEditTransactionView.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import SwiftUI

struct AddEditTransactionView: View {
    @EnvironmentObject private var router: AddEditTransactionRouter
    @StateObject private var vm: AddEditTransactionVM

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language(vm.isEdit ? "Add_Edit_Transaction_A_02" : "Add_Edit_Transaction_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    init(_ transaction: Transaction? = nil) {
        self._vm = StateObject(wrappedValue: AddEditTransactionVM(transaction))
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.zero) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        amountTextFieldView
                        selectCategoryRowView
                        datePickerRowVBiew
                    }.padding([.horizontal, .top], AppStyle.layout.standardSpace)
                }

                addEditTransactionButton
                    .padding(.bottom, AppStyle.layout.standardButtonHeight)
                    .padding(.horizontal, AppStyle.layout.standardSpace)
            }
        }
    }
}

private extension AddEditTransactionView {
    var addEditTransactionButton: some View {
        return Button {
            Vibration.selection.vibrate()
            // TODO: -
        } label: {
            Text(language(vm.isEdit ? "SS_Common_A_04" : "SS_Common_A_03"))
        }.buttonStyle(.standard())
    }

    var datePickerRowVBiew: some View {
        return DatePickerRowView(dateString: vm.dateSelectedString) {
            DatePickerView(dateDefault: vm.dateSelected, dateType: .day, isLimitYear: true) { dateSelected in
                vm.handleUpdateDateSelected(dateSelected)
            }.show()
        }
    }

    var selectCategoryRowView: some View {
        return SelectCategoryRowView(category: vm.category) {
            router.push(to: .categoryList)
        }
    }

    var amountTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.amount,
            placeHolder: language("Add_Edit_Transaction_A_06"),
            titleName: language("Add_Edit_Transaction_A_07")
        )).keyboardType(.decimalPad)
    }
}
