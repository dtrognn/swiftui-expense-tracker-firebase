//
//  Theme.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import SwiftUI

protocol STheme {
    var textNoteColor: Color { get }
    var textNormalColor: Color { get }
    var textUnderlineColor: Color { get }
    var textErrorMessageColor: Color { get }
    var textSelectedColor: Color { get }
    var textUnSelectedColor: Color { get }
    var textDeviceOnlineColor: Color { get }
    var textDeviceOfflineColor: Color { get }

    var btTextEnableColor: Color { get }
    var btTextDisableColor: Color { get }
    var btBackgroundEnableColor: Color { get }
    var btBackgroundDisableColor: Color { get }

    var naviTextColor: Color { get }
    var naviBackIconColor: Color { get }

    var tfBorderNormalColor: Color { get }
    var tfBorderActiveColor: Color { get }
    var tfFillNormalColor: Color { get }
    var tfFillDisableColor: Color { get }

    var shadowColor: Color { get }
    var lineColor: Color { get }
    var iconColor: Color { get }
    var iconNormalColor: Color { get }
    var iconHighlightColor: Color { get }

    var backgroundColor: Color { get }
    var rowCommonBackgroundColor: Color { get }
    var sectionBackgroundColor: Color { get }

    var tabbarBackgroundViewColor: Color { get }
    var tabbarViewColor: UIColor { get }

    var iconOnColor: Color { get }
    var iconOffColor: Color { get }

    var backgroundPopupColor: Color { get }

    var btnEnableColor: Color { get }
    var btnDisableColor: Color { get }
    var whiteTextColor: Color { get }
    var authenticationBackgroundColor: Color { get }
    var splashBackgroundColor: Color { get }

    var naviBackgroundColor: Color { get }
    var textHightlightColor: Color { get }
}

struct AppLightTheme: STheme {
    var splashBackgroundColor: Color { return Color(hexString: "#7F3DFF")! }
    var textHightlightColor: Color { return Color(hexString: "#7F3DFF")! }
    var naviBackgroundColor: Color { return Color(hexString: "#FFFFFF")! }

    var whiteTextColor: Color { return Color(hexString: "#FFFFFF")! }
    var authenticationBackgroundColor: Color { return Color(hexString: "#836096")! }

    var btnEnableColor: Color { return Color(hexString: "#C08261")! }
    var btnDisableColor: Color { return Color(hexString: "#9E9FA5")! }

    var textNoteColor: Color { return Color(hexString: "#91919F", opacity: 0.6)! } // "#262626")! }
    var textNormalColor: Color { return Color(hexString: "#000000")! }
    var textUnderlineColor: Color { return Color(hexString: "#7F3DFF")! } // Color { return Color.blue }

    var textErrorMessageColor: Color { return Color(hexString: "#E60A32")! }
    var textSelectedColor: Color { return Color(hexString: "#22313F")! }
    var textUnSelectedColor: Color { return Color(hexString: "#011222", opacity: 0.4)! }
    var textDeviceOnlineColor: Color { return Color(hexString: "#34c759")! }
    var textDeviceOfflineColor: Color { return Color(hexString: "#F59000")! }

    var btTextEnableColor: Color { return Color(hexString: "#FCFCFC")! }
    var btTextDisableColor: Color { return Color(hexString: "#7F3DFF")! }
    var btBackgroundEnableColor: Color { return Color(hexString: "#7F3DFF")! }
    var btBackgroundDisableColor: Color { return Color(hexString: "#EEE5FF")! }

    var naviBackIconColor: Color { return Color(hexString: "#22313F")! }
    var naviTextColor: Color { return Color(hexString: "#22313F")! }

    var tfBorderNormalColor: Color { return Color(hexString: "#011222", opacity: 0.1)! }
    var tfBorderActiveColor: Color { return Color(hexString: "#2F6BFF", opacity: 0.8)! }
    var tfFillNormalColor: Color { return Color(hexString: "#FFFFFF")! }
    var tfFillDisableColor: Color { return Color(hexString: "#011222", opacity: 0.05)! }

    var shadowColor: Color { return Color(hexString: "#000000")!.opacity(0.16) }
    var lineColor: Color { return Color(hexString: "#E6E6E6")! }

    var iconColor: Color { return Color(hexString: "#7F3DFF")! }
    var iconNormalColor: Color { return Color(hexString: "#22313F")! }
    var iconHighlightColor: Color { return Color(hexString: "#7F3DFF")! }
    var backgroundColor: Color { return Color(hexString: "#FFFFFF")! }
    var rowCommonBackgroundColor: Color { return Color(hexString: "#FFFFFF")! }
    var sectionBackgroundColor: Color { return Color(hexString: "#011222", opacity: 0.1)! }

    var tabbarBackgroundViewColor: Color { Color.gray.opacity(0.1) }
    var tabbarViewColor: UIColor { return UIColor.white }

    var iconOnColor: Color { return Color(hexString: "#7F3DFF")! }
    var iconOffColor: Color { return Color(hexString: "#011222", opacity: 0.5)! }

    var backgroundPopupColor: Color { return Color.black.opacity(0.2) }
}

struct AppDarkTheme: STheme {
    var splashBackgroundColor: Color { return Color(hexString: "#7F3DFF")! }
    var textHightlightColor: Color { return Color(hexString: "#7F3DFF")! }
    var naviBackgroundColor: Color { return Color(hexString: "#023047")! }

    var whiteTextColor: Color { return Color(hexString: "#FFFFFF")! }
    var authenticationBackgroundColor: Color { return Color(hexString: "#836096")! }

    var btnEnableColor: Color { return Color(hexString: "#C08261")! }
    var btnDisableColor: Color { return Color(hexString: "#9E9FA5")! }

    var textNoteColor: Color { return Color(hexString: "#91919F", opacity: 0.6)! } // "#262626")! }
    var textNormalColor: Color { return Color(hexString: "#FFFFFF")! }
    var textUnderlineColor: Color { return Color(hexString: "#7F3DFF")! } // Color { return Color.blue }

    var textErrorMessageColor: Color { return Color(hexString: "#E60A32")! }
    var textSelectedColor: Color { return Color(hexString: "#22313F")! }
    var textUnSelectedColor: Color { return Color(hexString: "#011222", opacity: 0.4)! }
    var textDeviceOnlineColor: Color { return Color(hexString: "#34c759")! }
    var textDeviceOfflineColor: Color { return Color(hexString: "#F59000")! }

    var btTextEnableColor: Color { return Color(hexString: "#FCFCFC")! }
    var btTextDisableColor: Color { return Color(hexString: "#7F3DFF")! }
    var btBackgroundEnableColor: Color { return Color(hexString: "#7F3DFF")! }
    var btBackgroundDisableColor: Color { return Color(hexString: "#EEE5FF")! }

    var naviBackIconColor: Color { return Color(hexString: "#FFFFFF")! }
    var naviTextColor: Color { return Color(hexString: "#FFFFFF")! }

    var tfBorderNormalColor: Color { return Color(hexString: "#011222", opacity: 0.1)! }
    var tfBorderActiveColor: Color { return Color(hexString: "#2F6BFF", opacity: 0.8)! }
    var tfFillNormalColor: Color { return Color(hexString: "#264653")! }
    var tfFillDisableColor: Color { return Color(hexString: "#011222", opacity: 0.05)! }

    var shadowColor: Color { return Color(hexString: "#000000")!.opacity(0.16) }
    var lineColor: Color { return Color(hexString: "#E6E6E6")! }

    var iconColor: Color { return Color(hexString: "#7F3DFF")! }
    var iconNormalColor: Color { return Color(hexString: "#22313F")! }
    var iconHighlightColor: Color { return Color(hexString: "#7F3DFF")! }
    var backgroundColor: Color { return Color(hexString: "#023047")! }
    var rowCommonBackgroundColor: Color { return Color(hexString: "#264653")! }
    var sectionBackgroundColor: Color { return Color(hexString: "#011222", opacity: 0.1)! }

    var tabbarBackgroundViewColor: Color { return Color(hexString: "#264653")! }
    var tabbarViewColor: UIColor { return UIColor.white }

    var iconOnColor: Color { return Color(hexString: "#7F3DFF")! }
    var iconOffColor: Color { return Color(hexString: "#011222", opacity: 0.5)! }

    var backgroundPopupColor: Color { return Color.black.opacity(0.2) }
}
