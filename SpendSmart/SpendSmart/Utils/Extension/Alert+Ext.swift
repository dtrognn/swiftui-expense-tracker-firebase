//
//  Alert+Ext.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

extension Alert {
    static func alert(_ alertConfiguration: AlertConfiguration) -> Alert {
        if let secondaryButtonText = alertConfiguration.secondaryButtonText {
            return Alert(title: Text(alertConfiguration.title),
                         message: alertConfiguration.message != nil ? Text(alertConfiguration.message!.toLocalizedStringKey()) : nil,
                         primaryButton: .default(Text(alertConfiguration.primaryButtonText.toLocalizedStringKey()), action: alertConfiguration.primaryAction),
                         secondaryButton: .default(Text(secondaryButtonText.toLocalizedStringKey()), action: alertConfiguration.secondaryAction))
        }

        return Alert(title: Text(alertConfiguration.title.toLocalizedStringKey()),
                     message: alertConfiguration.message != nil ? Text(alertConfiguration.message!.toLocalizedStringKey()) : nil,
                     dismissButton: .cancel(Text(alertConfiguration.primaryButtonText.toLocalizedStringKey()), action: alertConfiguration.primaryAction))
    }
}
