//
//  HomeView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import Charts
import SwiftUI

struct HomeView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject private var router: HomeRouter
    @StateObject private var vm = HomeVM()

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: AppStyle.layout.standardSpace), count: 4)

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: "",
            showBackButton: false,
            showNavibar: false,
            hidesBottomBarWhenPushed: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.zero) {
                headerView

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        featuresView
                        recentTransactionsView
                    }.padding(.vertical, AppStyle.layout.standardSpace)
                }
            }.padding(.bottom, UITabBarController().height + safeAreaInsets.bottom)
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
            }
        }.padding(.horizontal, AppStyle.layout.standardSpace)
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
}

// MARK: - Features

private extension HomeView {
    var featuresView: some View {
        return VStack(spacing: AppStyle.layout.standardSpace) {
            featureHeaderView

            LazyVGrid(columns: columns, spacing: AppStyle.layout.standardSpace) {
                ForEach(Feature.allCases) { feature in
                    FeatureItemView(feature) { featureSelected in
                        switch featureSelected {
                        case .saving:
                            router.push(to: .saving)
                        default:
                            return
                        }
                    }
                }
            }.frame(maxWidth: .infinity)
                .padding(.vertical, AppStyle.layout.mediumSpace)
                .background(AppStyle.theme.rowCommonBackgroundColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
                .applyShadowView()
        }.padding(.horizontal, AppStyle.layout.standardSpace)
    }

    var featureHeaderView: some View {
        return HStack {
            featureText
            Spacer()
        }
    }

    var featureText: some View {
        return Text(language("Home_A_06"))
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}

// MARK: - Recent transactions

private extension HomeView {
    var recentTransactionsView: some View {
        return VStack(spacing: AppStyle.layout.standardSpace) {
            HStack(spacing: AppStyle.layout.zero) {
                recentTransactionText
                Spacer()
                seeAllButton
            }

            if vm.transactions.isEmpty {
                VStack(spacing: AppStyle.layout.standardSpace) {
                    noRecentTransView
                    addTransLargeButton
                }
            } else {
                LazyVStack(spacing: AppStyle.layout.zero) {
                    ForEach(vm.transactions) { transition in
                        TransactionItemView(transaction: transition)
                    }
                }.applyShadowView()
            }
        }.padding(.all, AppStyle.layout.standardSpace)
    }

    var recentTransactionText: some View {
        return Text(language("Home_A_01"))
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var seeAllButton: some View {
        return Button {
            router.push(to: .recentTransaction)
        } label: {
            Text(language("Home_A_02"))
                .font(AppStyle.font.regular16)
                .foregroundColor(AppStyle.theme.textHightlightColor)
        }
    }

    var addTransLargeButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.push(to: .addEditTransaction(nil))
        } label: {
            Text(language("Home_A_05"))
                .font(AppStyle.font.semibold16)
                .foregroundColor(AppStyle.theme.btTextEnableColor)
                .padding(.vertical, AppStyle.layout.mediumSpace)
                .padding(.horizontal, AppStyle.layout.standardSpace)
                .background(AppStyle.theme.btBackgroundEnableColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
        }
    }

    var noRecentTransView: some View {
        return Text(language("Home_A_03"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
