//
//  ChangeLanguageView.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

struct ChangeLanguageView: View {
    @StateObject private var vm = ChangeLanguageVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Language_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack(spacing: AppStyle.layout.zero) {
                ForEach(vm.languageList) { item in
                    LanguageItemView(data: item)
                }
                Spacer()
            }.padding(.all, AppStyle.layout.standardSpace)
                .applyShadowView()
        }.environment(\.locale, .init(identifier: LanguageManager.shared.currentLanguage.getLanguageCode()))
    }
}
