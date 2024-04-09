//
//  HomeView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: HomeRouter
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

                ScrollView(.vertical, showsIndicators: false) {
                    recentTransactionsView
                }
            }
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
            router.push(to: .addEditTransaction(nil))
        } label: {
            Image(systemName: "plus.app")
                .resizable()
                .applyTheme()
                .frame(width: 22, height: 22)
        }
    }

    var addCategoryButton: some View {
        return Button {
            router.push(to: .addNewCategory(nil))
        } label: {
            Image(systemName: "plus.circle")
                .resizable()
                .applyTheme()
                .frame(width: 22, height: 22)
        }
    }
}

private extension HomeView {
    var recentTransactionsView: some View {
        return VStack(spacing: AppStyle.layout.standardSpace) {
            HStack(spacing: AppStyle.layout.zero) {
                recentTransactionText
                Spacer()
                seeAllButton
            }

            LazyVStack(spacing: AppStyle.layout.zero) {
                ForEach(vm.transitions.prefix(5)) { transition in
                    TransactionItemView(transaction: transition)
                }
            }.applyShadowView()
        }.padding(.all, AppStyle.layout.standardSpace)
    }

    var recentTransactionText: some View {
        return Text(language("Home_A_01"))
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var seeAllButton: some View {
        return Button {
            // TODO: -
        } label: {
            Text(language("Home_A_02"))
                .font(AppStyle.font.regular16)
                .foregroundColor(AppStyle.theme.textHightlightColor)
        }
    }
}
