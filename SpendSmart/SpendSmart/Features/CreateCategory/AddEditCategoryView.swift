//
//  CreateCategoryView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct AddEditCategoryView: View {
    @StateObject private var vm: AddEditCategoryVM

    @State private var showColorPickerSheet: Bool = false
    @State private var showIConPickerSheet: Bool = false
    @State private var heightOfSelectColorView: CGFloat = .zero
    @State private var heightOfSelectIconView: CGFloat = .zero

    init(_ category: Category? = nil) {
        self._vm = StateObject(wrappedValue: AddEditCategoryVM(category))
    }

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Create_Category_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.standardSpace) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(spacing: AppStyle.layout.standardSpace) {
                            categoryNameTextFieldView
                            selectColorRowView
                            selectIconRowView
                        }
                    }.padding(.all, AppStyle.layout.standardSpace)
                }

                addEditCategoryButton
                    .padding(.bottom, AppStyle.layout.standardButtonHeight)
                    .padding(.horizontal, AppStyle.layout.standardSpace)
            }
        }.sheet(isPresented: $showColorPickerSheet) {
            CategorySelectColorView(selectedColor: vm.selectedColor, onUpdateHeight: { height in
                self.heightOfSelectColorView = height
            }, onSelect: { selectedColor in
                vm.selectedColor = selectedColor
                showColorPickerSheet = false
            }).presentationDetents([.height(heightOfSelectColorView), .medium, .large])
                .presentationDragIndicator(.automatic)
        }.sheet(isPresented: $showIConPickerSheet) {
            CategorySelectIconView(selectedColor: vm.selectedColor,
                                   selectedIcon: vm.selectedIcon,
                                   onUpdateHeight: { height in
                                       self.heightOfSelectIconView = height
                                   }) { selectedIcon in
                vm.selectedIcon = selectedIcon
                showIConPickerSheet = false
            }
        }
    }
}

private extension AddEditCategoryView {
    var categoryNameTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.categoryName,
            placeHolder: language("Create_Category_A_02"),
            titleName: language("Create_Category_A_03")
        ))
    }

    var selectColorRowView: some View {
        return CategorySelectColorRowView(selectedColor: vm.selectedColor) {
            showColorPickerSheet = true
        }
    }

    var selectIconRowView: some View {
        return CategorySelectIconRowView(bgColor: vm.selectedColor, selectedIcon: vm.selectedIcon) {
            showIConPickerSheet = true
        }
    }

    var addEditCategoryButton: some View {
        return Button {
            Vibration.selection.vibrate()
        } label: {
            Text(language(vm.isEdit ? "Create_Category_A_07" : "Create_Category_A_06"))
        }.buttonStyle(.standard(isActive: !vm.categoryName.isEmpty))
    }
}
