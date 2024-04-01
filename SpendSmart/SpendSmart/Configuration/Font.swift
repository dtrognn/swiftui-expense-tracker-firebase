//
//  Font.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import SwiftUI

protocol SFont {
    var regular10: Font { get }
    var regular12: Font { get }
    var regular13: Font { get }
    var regular14: Font { get }
    var regular15: Font { get }
    var regular16: Font { get }
    var regular17: Font { get }
    var regular18: Font { get }
    var regular20: Font { get }
    var regular24: Font { get }
    var regular30: Font { get }
    var regular32: Font { get }
    var regular40: Font { get }

    var semibold10: Font { get }
    var semibold12: Font { get }
    var semibold14: Font { get }
    var semibold15: Font { get }
    var semibold16: Font { get }
    var semibold17: Font { get }
    var semibold18: Font { get }
    var semibold20: Font { get }
    var semibold24: Font { get }
    var semibold30: Font { get }
    var semibold32: Font { get }
    var semibold40: Font { get }

    var medium6: Font { get }
    var medium10: Font { get }
    var medium12: Font { get }
    var medium14: Font { get }
    var medium15: Font { get }
    var medium16: Font { get }
    var medium17: Font { get }
    var medium18: Font { get }
    var medium20: Font { get }
    var medium24: Font { get }
    var medium30: Font { get }
    var medium32: Font { get }
    var medium40: Font { get }

    var bold10: Font { get }
    var bold12: Font { get }
    var bold14: Font { get }
    var bold15: Font { get }
    var bold16: Font { get }
    var bold17: Font { get }
    var bold18: Font { get }
    var bold20: Font { get }
    var bold22: Font { get }
    var bold24: Font { get }
    var bold32: Font { get }
    var bold40: Font { get }
}

extension Font {
    static func regular(ofSize size: CGFloat) -> Font {
//        return FontManager.setFontSwiftUI(size, fontName: .SFProDisplayRegular)
        return Font.system(size: size, weight: .light, design: .default)
    }

    static func bold(ofSize size: CGFloat) -> Font {
//        return FontManager.setFontSwiftUI(size, fontName: .SFProDisplayBold)
        return Font.system(size: size, weight: .bold, design: .default)
    }

    static func semibold(ofSize size: CGFloat) -> Font {
//        return FontManager.setFontSwiftUI(size, fontName: .SFProDisplaySemibold)
        return Font.system(size: size, weight: .semibold, design: .default)
    }

    static func medium(ofSize size: CGFloat) -> Font {
//        return FontManager.setFontSwiftUI(size, fontName: .SFProDisplayMedium)
        return Font.system(size: size, weight: .medium, design: .default)
    }
}

struct AppFont: SFont {
    var regular10: Font { Font.regular(ofSize: 10) }
    var regular12: Font { Font.regular(ofSize: 12) }
    var regular13: Font { Font.regular(ofSize: 13) }
    var regular14: Font { Font.regular(ofSize: 14) }
    var regular15: Font { Font.regular(ofSize: 15) }
    var regular16: Font { Font.regular(ofSize: 16) }
    var regular17: Font { Font.regular(ofSize: 17) }
    var regular18: Font { Font.regular(ofSize: 18) }
    var regular20: Font { Font.regular(ofSize: 20) }
    var regular24: Font { Font.regular(ofSize: 24) }
    var regular30: Font { Font.regular(ofSize: 30) }
    var regular32: Font { Font.regular(ofSize: 32) }
    var regular40: Font { Font.regular(ofSize: 40) }

    var semibold10: Font { Font.semibold(ofSize: 10) }
    var semibold12: Font { Font.semibold(ofSize: 12) }
    var semibold14: Font { Font.semibold(ofSize: 14) }
    var semibold15: Font { Font.semibold(ofSize: 15) }
    var semibold16: Font { Font.semibold(ofSize: 16) }
    var semibold17: Font { Font.semibold(ofSize: 17) }
    var semibold18: Font { Font.semibold(ofSize: 18) }
    var semibold20: Font { Font.semibold(ofSize: 20) }
    var semibold24: Font { Font.semibold(ofSize: 24) }
    var semibold30: Font { Font.semibold(ofSize: 30) }
    var semibold32: Font { Font.semibold(ofSize: 32) }
    var semibold40: Font { Font.semibold(ofSize: 40) }

    var medium6: Font { Font.medium(ofSize: 6) }
    var medium10: Font { Font.medium(ofSize: 10) }
    var medium12: Font { Font.medium(ofSize: 12) }
    var medium14: Font { Font.medium(ofSize: 14) }
    var medium15: Font { Font.medium(ofSize: 15) }
    var medium16: Font { Font.medium(ofSize: 16) }
    var medium17: Font { Font.medium(ofSize: 17) }
    var medium18: Font { Font.medium(ofSize: 18) }
    var medium20: Font { Font.medium(ofSize: 20) }
    var medium24: Font { Font.medium(ofSize: 24) }
    var medium30: Font { Font.medium(ofSize: 30) }
    var medium32: Font { Font.medium(ofSize: 32) }
    var medium40: Font { Font.medium(ofSize: 40) }

    var bold10: Font { Font.bold(ofSize: 10) }
    var bold12: Font { Font.bold(ofSize: 12) }
    var bold14: Font { Font.bold(ofSize: 14) }
    var bold15: Font { Font.bold(ofSize: 15) }
    var bold16: Font { Font.bold(ofSize: 16) }
    var bold17: Font { Font.bold(ofSize: 17) }
    var bold18: Font { Font.bold(ofSize: 18) }
    var bold20: Font { Font.bold(ofSize: 20) }
    var bold22: Font { Font.bold(ofSize: 24) }
    var bold24: Font { Font.bold(ofSize: 30) }
    var bold32: Font { Font.bold(ofSize: 32) }
    var bold40: Font { Font.bold(ofSize: 40) }
}
