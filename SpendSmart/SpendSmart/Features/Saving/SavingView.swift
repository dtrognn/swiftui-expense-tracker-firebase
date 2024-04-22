//
//  SavingView.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

struct SavingView: View {
    @EnvironmentObject private var router: SavingRouter
    @StateObject private var vm = SavingVM()

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Saving_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    //
                }
            }
        }
    }
}
