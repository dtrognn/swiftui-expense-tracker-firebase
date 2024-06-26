//
//  TabbarRouterView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct TabItemData {
    var title: LocalizedStringKey
    var normalImage: Image
    var slectedImage: Image
}

struct TabItem: View {
    let tabType: TabbarRouter.TabType
    private let tabItemData: TabItemData

    init(tabType: TabbarRouter.TabType) {
        self.tabType = tabType
        self.tabItemData = tabType.tabItemData()
    }

    let colorSelection = Color.brown

    var body: some View {
        Label {
            Text(tabItemData.title)
                .foregroundColor(colorSelection)
        } icon: {
            tabItemData.normalImage
                .renderingMode(.template)
                .foregroundColor(.gray)
        }
    }
}

class TabbarRouter: ObservableObject {
    enum TabType: Hashable {
        case home
        case search
        case profile

        func tabItemData() -> TabItemData {
            switch self {
            case .home:
                return TabItemData(title: language("Tabbar_A_01"), normalImage: Image("ic_tab_home_2"), slectedImage: Image("ic_tab_home_2"))
            case .search:
                return TabItemData(title: language("Tabbar_A_02"), normalImage: Image("ic_tab_chart"), slectedImage: Image("ic_tab_chart"))
            case .profile:
                return TabItemData(title: language("Tabbar_A_03"), normalImage: Image("ic_tab_profile"), slectedImage: Image("ic_tab_profile"))
            }
        }
    }

    @Published var selectedTab: TabType = .home
}

struct TabbarRouterView: View {
    @StateObject private var router = TabbarRouter()

    var body: some View {
        tabview.accentColor(.brown)
    }

    var tabview: some View {
        TabView(selection: $router.selectedTab) {
            HomeRouterView().tabItem { TabItem(tabType: .home) }
                .tag(TabbarRouter.TabType.home)

            AnalyticsRouterView().tabItem { TabItem(tabType: .search) }
                .tag(TabbarRouter.TabType.search)

            ProfileRouterView().tabItem { TabItem(tabType: .profile) }
                .tag(TabbarRouter.TabType.profile)
        }.tag(TabbarRouter.TabType.profile)
            .accentColor(AppStyle.theme.iconColor)
    }
}
