//
//  CreateCategoryView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct AddNewCategoryView: View {
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
                //
            }
        }
    }
}
