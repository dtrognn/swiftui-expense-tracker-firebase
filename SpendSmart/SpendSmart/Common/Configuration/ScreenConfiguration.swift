//
//  ScreenConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import SwiftUI

public class ScreenConfiguration: ObservableObject {
    @Published public var title: String
    @Published public var showBackButton: Bool
    @Published public var hidesBottomBarWhenPushed: Bool
    @Published public var showNavibar: Bool
    @Published public var onBackAction: (() -> Void)?
    @Published public var swipeToBack: Bool
    @Published public var showPopToRootButton: Bool
    @Published public var depthScreen: Int

    public init(title: String,
        showBackButton: Bool = true,
        showNavibar: Bool = true,
        showPopToRootButton: Bool = true,
        depthScreen: Int = 4,
        hidesBottomBarWhenPushed: Bool = true,
        swipeToBack: Bool = true,
        onBackAction: (() -> Void)? = nil) {
        self.title = title
        self.showBackButton = showBackButton
        self.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        self.showNavibar = showNavibar
        self.swipeToBack = swipeToBack
        self.onBackAction = onBackAction
        self.showPopToRootButton = showPopToRootButton
        self.depthScreen = depthScreen
    }
}
