//
//  AlertMessageConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 04/04/2024.
//

import Foundation

enum AlertMessageStyle {
    case danger
    case info
    case customView
    case success
    case warning
}

enum AlertMessageType {
    case defaultAlert
    case banner
    case custom
}

protocol IAlertMessage: AnyObject {
    func showMessage(_ message: String, style: AlertMessageStyle)
}

class AlertMessageConfiguration {
    static let shared = AlertMessageConfiguration()

    private var alertMessageDict: [AlertMessageType: IAlertMessage] = [:]

    func addAlertMessage(_ alertMessageType: AlertMessageType, alertMessage: IAlertMessage) {
        alertMessageDict[alertMessageType] = alertMessage
    }

    func showMessage(_ message: String, alertMessageType: AlertMessageType = .defaultAlert, style: AlertMessageStyle = .info) {
        alertMessageDict[alertMessageType]?.showMessage(message, style: style)
    }
}
