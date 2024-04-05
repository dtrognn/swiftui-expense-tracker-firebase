//
//  HomeView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeVM()

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
            VStack(spacing: AppStyle.layout.zero) {
                headerView
            }
        }.onAppear {
            vm.loadDataUser()
        }
    }
}

private extension HomeView {
    var headerView: some View {
        return HStack {
            usernameText
            Spacer()
            HStack(spacing: AppStyle.layout.mediumSpace) {
                addExpenseButton
                addCategoryButton
            }
        }.padding(.horizontal, AppStyle.layout.standardSpace)
            .padding(.bottom, AppStyle.layout.mediumSpace)
    }

    var usernameText: some View {
        return Text(vm.username)
            .font(AppStyle.font.semibold24)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var addExpenseButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "plus.app")
                .resizable()
                .applyTheme()
                .frame(width: 22, height: 22)
        }
    }

    var addCategoryButton: some View {
        return Button {
            // TODO: -
        } label: {
            Image(systemName: "plus.circle")
                .resizable()
                .applyTheme()
                .frame(width: 22, height: 22)
        }
    }
}
