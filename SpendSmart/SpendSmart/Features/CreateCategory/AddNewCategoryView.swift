//
//  CreateCategoryView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct AddNewCategoryView: View {
    @StateObject private var vm = AddNewCategoryVM()

    @State private var showColorPickerSheet: Bool = false
    @State private var heightOfSelectColorView: CGFloat = .zero

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
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        categoryNameTextFieldView
                        selectColorRowView
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }
        }.sheet(isPresented: $showColorPickerSheet) {
            CategorySelectColorView(selectedColor: .bronze, onUpdateHeight: { height in
                self.heightOfSelectColorView = height
            }, onSelect: { _ in
                // TODO: -
            }).presentationDetents([.height(heightOfSelectColorView), .medium, .large])
                .presentationDragIndicator(.automatic)
        }
    }
}

private extension AddNewCategoryView {
    var categoryNameTextFieldView: some View {
        return InputTextField(TextFieldConfiguration(
            text: $vm.categoryName,
            placeHolder: language("Create_Category_A_02"),
            titleName: language("Create_Category_A_03")
        ))
    }

    var selectColorRowView: some View {
        return CategorySelectColorRowView(selectedColor: .bronze) {
            Vibration.selection.vibrate()
            showColorPickerSheet = true
        }
    }
}
