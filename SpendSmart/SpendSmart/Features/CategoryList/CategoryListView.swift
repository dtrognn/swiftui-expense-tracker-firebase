//
//  CategoryListView.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject private var router: CategoryListRouter

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Category_List_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    addNewCategoryButton
                }.padding(.all, AppStyle.layout.standardSpace)
            }
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
            }.applyShadowView()
        }
    }

    var plusImage: some View {
        return Image(systemName: "plus.circle.fill").applyTheme()
    }

    var addNewCategoryText: some View {
        return Text(language("Category_List_A_03"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
