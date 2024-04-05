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
            test
        }.padding(.horizontal, AppStyle.layout.standardSpace)
    }

    var usernameText: some View {
        return Text(vm.username)
            .font(AppStyle.font.medium20)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var test: some View {
        Text("ydbfuydsbf")
    }
}
