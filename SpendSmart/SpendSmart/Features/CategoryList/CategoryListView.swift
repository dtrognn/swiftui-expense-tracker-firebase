//
//  CategoryListView.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject private var router: CategoryListRouter
    @StateObject private var vm: CategoryListVM

    @State private var showAlert: Bool = false

    init(_ actionType: CategoryActionType) {
        self._vm = StateObject(wrappedValue: CategoryListVM(actionType))
    }

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Category_List_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScreenContainerView(screenConfiguration) {
                VStack(spacing: AppStyle.layout.mediumSpace) {
                    addNewCategoryButton

                    if vm.categories.isEmpty {
                        noCategoryView
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: AppStyle.layout.standardSpace) {
                                LazyVStack(spacing: AppStyle.layout.zero) {
                                    ForEach(vm.categories) { category in
                                        CategoryItemView(category) { categorySelected in
                                            switch vm.actionType {
                                            case .select:
                                                vm.updateCategorySeleted(categorySelected)
                                                router.popView()
                                            case .update:
                                                router.push(to: .addEditCategory(categorySelected))
                                            }
                                        } onDelete: { categoryDeleteSelected in
                                            vm.categorySelected = categoryDeleteSelected
                                            showAlert = true
                                        }
                                    }
                                }
                            }.background(AppStyle.theme.rowCommonBackgroundColor)
                                .cornerRadius(AppStyle.layout.standardCornerRadius)
                                .applyShadowView()
                                .padding(.vertical, AppStyle.layout.mediumSpace)
                        }.refreshable {
                            Task { vm.getData(true) }
                        }
                    }

                    Spacer()

                    if vm.showOptionSelect {
                        deleteButton
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }

//            editButton
        }.overlay(vm.showOptionSelect ? optionEditView.asAnyView : EmptyView().asAnyView, alignment: .top)
            .alertView(alerConfiguration)
    }
}

private extension CategoryListView {
    var optionEditView: some View {
        return OptionEditView(
            numberItemSelected: $vm.numberOfItemSelected,
            onClose: {
                vm.showOptionSelect = false
                vm.enableModeSelect(false)
            }, onSelectAll: { isSelectAll in
                vm.selectAll(isSelectAll)
            }
        )
    }

    var editButton: some View {
        return Button {
            vm.showOptionSelect = true
            vm.enableModeSelect(true)
        } label: {
            Image(systemName: "square.and.pencil")
                .resizable()
                .applyTheme(AppStyle.theme.naviBackIconColor)
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(.all, AppStyle.layout.standardSpace)
        }
    }

    var deleteButton: some View {
        return Button {
            Vibration.selection.vibrate()
            showAlert = true
        } label: {
            Text(language("SS_Common_A_08"))
        }.buttonStyle(.standard(isActive: vm.numberOfItemSelected != 0))
            .padding(.bottom, AppStyle.layout.standardButtonHeight)
    }

    var alerConfiguration: AlertConfiguration {
        return AlertConfiguration(
            isPresented: $showAlert,
            title: language("Category_List_A_04"),
            message: language("Category_List_A_05"),
            primaryButtonText: language("SS_Common_A_09"),
            secondaryButtonText: language("SS_Common_A_10")
        ) {} secondaryAction: {
            vm.deleteCategory()
        }
    }
}

private extension CategoryListView {
    var addNewCategoryButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.push(to: .addEditCategory(nil))
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.zero) {
                    HStack(spacing: AppStyle.layout.standardSpace) {
                        plusImage
                        addNewCategoryText
                    }
                    Spacer()
                }.padding(.all, AppStyle.layout.standardSpace)
            }.background(AppStyle.theme.rowCommonBackgroundColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
                .applyShadowView()
        }
    }

    var noCategoryView: some View {
        return Button {
            router.push(to: .addEditCategory(nil))
        } label: {
            Text(language("Category_List_A_02"))
                .font(AppStyle.font.regular16)
                .foregroundColor(AppStyle.theme.textUnderlineColor)
                .multilineTextAlignment(.center)
                .padding(.top, AppStyle.layout.standardSpace)
        }
    }

    var plusImage: some View {
        return Image(systemName: "plus.circle.fill")
            .resizable()
            .applyTheme()
            .frame(width: 30, height: 30)
    }

    var addNewCategoryText: some View {
        return Text(language("Category_List_A_03"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
