//
//  AddEditSavingView.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

struct AddEditSavingView: View {
    @EnvironmentObject private var router: AddEditSavingRouter
    @StateObject private var vm: AddEditSavingVM

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Saving_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    init(_ saving: Saving? = nil) {
        self._vm = StateObject(wrappedValue: AddEditSavingVM(saving))
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        //
                    }
                }

                Spacer()
                // button
            }
        }
    }
}
