//
//  TextFieldConfiguration.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

public struct TextFieldConfiguration {
//    public var id: String = UUID().uuidString
    public var text: Binding<String>
    public var placeHolder: String
    public var titleName: String
    public var errorMessage: String?
    public var showErrorMessage: Binding<Bool>
    public var textMaxLength: Int?
    public var isSecure: Bool
    public var isDisable: Bool
    public var onSelect: (() -> Void)?

    public init(text: Binding<String>,
                placeHolder: String,
                titleName: String,
                errorMessage: String? = nil,
                showErrorMessage: Binding<Bool> = .constant(false),
                textMaxLength: Int? = nil,
                isSecure: Bool = false,
                isDisable: Bool = false,
                onSelect: (() -> Void)? = nil)
    {
        self.text = text
        self.placeHolder = placeHolder
        self.titleName = titleName
        self.errorMessage = errorMessage
        self.showErrorMessage = showErrorMessage
        self.textMaxLength = textMaxLength
        self.isSecure = isSecure
        self.isDisable = isDisable
        self.onSelect = onSelect
    }
}
