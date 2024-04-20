//
//  AppStyle.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import UIKit

struct AppStyle {
    static var font: SFont = AppFont()
    static var layout: SLayout = AppLayout()

    private static var lightTheme: STheme = AppLightTheme()
    private static var darkTheme: STheme = AppDarkTheme()
    static var theme: STheme = lightTheme

    static var isDarkMode: Bool = false {
        didSet {
            theme = isDarkMode ? darkTheme : lightTheme
            UITabBar.appearance().backgroundColor = theme.tabbarBackgroundViewColor.asUIColor()
        }
    }

    init() {}
}
