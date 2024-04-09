//
//  AddEditTransactionView.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import SwiftUI

struct AddEditTransactionView: View {
    @EnvironmentObject private var router: AddEditTransactionRouter
    @StateObject private var vm = AddEditTransactionVM.shared

    private var textEditorHeight: CGFloat = 70

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language(vm.isEdit ? "Add_Edit_Transaction_A_02" : "Add_Edit_Transaction_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.zero) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        HStack(spacing: AppStyle.layout.standardSpace) {
                            amountTextFieldView
                            unitButton
                        }
                        transactionTypeView
                        descriptionTextEditorView
                        selectCategoryRowView
                        datePickerRowVBiew
                    }.padding([.horizontal, .top], AppStyle.layout.standardSpace)
                }

                addEditTransactionButton
                    .padding(.bottom, AppStyle.layout.standardButtonHeight)
                    .padding(.horizontal, AppStyle.layout.standardSpace)
            }
        }.onReceive(vm.onAddEditTransitionSuccess) { _ in
            router.popView()
        }
    }
}

private extension AddEditTransactionView {
    var addEditTransactionButton: some View {
        return Button {
            Vibration.selection.vibrate()
            vm.addUpdateTransaction()
        } label: {
            Text(language(vm.isEdit ? "SS_Common_A_04" : "SS_Common_A_03"))
        }.buttonStyle(.standard())
    }

    var unitButton: some View {
        return MenuView(selectUnitMenuConfiguration) {
            Text(vm.unit.symbol)
                .font(AppStyle.font.medium16)
                .foregroundColor(AppStyle.theme.textHightlightColor)
        }
    }

    var selectUnitMenuConfiguration: MenuConfiguration {
        return MenuConfiguration(menuItemList: unitMenuConfigurationList) { menu in
            didSelectUnitMenu(menu)
        }
    }

    var unitMenuConfigurationList: [MenuItemConfiguration] {
        return Unit.allCases.map {
            MenuItemConfiguration(title: $0.title, data: $0)
        }
    }

    func didSelectUnitMenu(_ menu: MenuItemConfiguration) {
        guard let unit = menu.data as? Unit else { return }
        vm.unit = unit
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
            router.push(to: .categoryList(.select))
        }
    }

    var amountTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.amount,
            placeHolder: language("Add_Edit_Transaction_A_06"),
            titleName: language("Add_Edit_Transaction_A_07")
        )).keyboardType(.decimalPad)
    }

    var descriptionTextEditorView: some View {
        return AutoHeightEditor(
            text: $vm.description,
            teHeight: textEditorHeight,
            maxLine: 5,
            hasBorder: true,
            isEnabled: .constant(true),
            disabledPlaceholder: language("Add_Edit_Transaction_A_04"),
            regExpUse: .none
        ).frame(height: textEditorHeight)
    }

    var transactionTypeView: some View {
        return HStack(spacing: AppStyle.layout.hugeSpace) {
            expenseButton
            incomeButton
            Spacer()
        }
    }

    var expenseButton: some View {
        return Button {
            vm.transactionType = .expense
        } label: {
            HStack(spacing: AppStyle.layout.mediumSpace) {
                radioExpense
                expenseText
            }
        }
    }

    var incomeButton: some View {
        return Button {
            vm.transactionType = .income
        } label: {
            HStack(spacing: AppStyle.layout.mediumSpace) {
                radioIncome
                incomeText
            }
        }
    }

    var radioExpense: some View {
        return Image(systemName: vm.transactionType == .expense ? "record.circle" : "circle")
            .applyTheme(vm.transactionType == .expense ? AppStyle.theme.iconHighlightColor : AppStyle.theme.iconNormalColor)
    }

    var radioIncome: some View {
        return Image(systemName: vm.transactionType == .income ? "record.circle" : "circle")
            .applyTheme(vm.transactionType == .income ? AppStyle.theme.iconHighlightColor : AppStyle.theme.iconNormalColor)
    }

    var expenseText: some View {
        return Text(language("SS_Common_A_11"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var incomeText: some View {
        return Text(language("SS_Common_A_12"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
