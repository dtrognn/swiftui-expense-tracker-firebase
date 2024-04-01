//
//  Layout.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import Foundation

protocol SLayout {
    var zero: CGFloat { get }
    var smallSpace: CGFloat { get }
    var lineSpacing: CGFloat { get }
    var mediumSpace: CGFloat { get }
    var standardSpace: CGFloat { get }
    var largeSpace: CGFloat { get }
    var hugeSpace: CGFloat { get }
    var bottomButtonSpace: CGFloat { get }
    var standardButtonHeight: CGFloat { get }
    var standardCornerRadius: CGFloat { get }
    var largeCornerRadius: CGFloat { get }
    var iconDeviceSize: CGSize { get }

    var standardTextFieldHeight: CGFloat { get }
    var largeTextFieldHeight: CGFloat { get }
    var lineWidth: CGFloat { get }
}

struct AppLayout: SLayout {
    var largeTextFieldHeight: CGFloat { 150.0 }
    var lineWidth: CGFloat { 2.0 }
    var standardTextFieldHeight: CGFloat { 55.0 }

    var zero: CGFloat { 0.0 }
    var smallSpace: CGFloat { 4.0 }
    var lineSpacing: CGFloat { 6.0 }
    var mediumSpace: CGFloat { 8.0 }
    var standardSpace: CGFloat { 16.0 }
    var largeSpace: CGFloat { 24.0 }
    var hugeSpace: CGFloat { 32.0 }
    var bottomButtonSpace: CGFloat { 44.0 }
    var standardButtonHeight: CGFloat { 44.0 }
    var standardCornerRadius: CGFloat { 8.0 }
    var largeCornerRadius: CGFloat { 16.0 }
    var iconDeviceSize: CGSize { CGSize(width: 70.0, height: 70.0) }
}
