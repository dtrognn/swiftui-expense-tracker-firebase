//
//  AlertConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

struct AlertConfiguration {
    var isPresented: Binding<Bool>
    var title: String
    var message: String?
    var primaryButtonText: String
    var secondaryButtonText: String?
    var primaryAction: (() -> Void)?
    var secondaryAction: (() -> Void)?

    init(isPresented: Binding<Bool>,
         title: String,
         message: String? = nil,
         primaryButtonText: String,
         secondaryButtonText: String? = nil,
         primaryAction: (() -> Void)? = nil,
         secondaryAction: (() -> Void)? = nil)
    {
        self.isPresented = isPresented
        self.title = title
        self.message = message
        self.primaryButtonText = primaryButtonText
        self.secondaryButtonText = secondaryButtonText
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}
