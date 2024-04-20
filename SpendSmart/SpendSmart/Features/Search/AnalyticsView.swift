//
//  SearchView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct AnalyticsView: View {
    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: "",
            showBackButton: false,
            showNavibar: false,
            hidesBottomBarWhenPushed: false)
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
