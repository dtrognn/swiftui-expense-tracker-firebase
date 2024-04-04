//
//  InputTextField.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import Combine
import SwiftUI

public struct InputTextField: View {
    public var configurationData: TextFieldConfiguration
    @State private var isShowPassword = true
    @State private var isFocused = false
    @State private var visibleText: String = ""

    public init(_ configurationData: TextFieldConfiguration) {
        self.configurationData = configurationData
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: AppStyle.layout.smallSpace) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: AppStyle.layout.standardCornerRadius, style: .continuous)
                    .style(withStroke: boderColor(), lineWidth: 1, fill: fillColor())
                    .frame(height: 56)

                HStack(spacing: AppStyle.layout.zero) {
                    VStack (alignment: .leading, spacing: AppStyle.layout.smallSpace) {
                        if !configurationData.text.wrappedValue.isEmpty {
                            titleNameText
                        }

                        if configurationData.isSecure {
                            if isShowPassword {
                                secureField
                            } else {
                                hideSecureField
                            }
                        } else {
                            textField.onReceive(Just(configurationData.text), perform: { _ in
                                    if let textMaxLength = configurationData.textMaxLength {
                                        self.limitText(textMaxLength)
                                    }
                                }).background(backgroundColorTextField())
                        }
                    }.padding(.leading, AppStyle.layout.standardSpace)

                    if configurationData.isSecure {
                        secureButton.frame(width: 40, height: 40)
                            .padding(.vertical, AppStyle.layout.mediumSpace)
                            .padding(.trailing, AppStyle.layout.mediumSpace)
                    } else {
                        clearTextButton.frame(width: 40, height: 40)
                            .padding(.vertical, AppStyle.layout.mediumSpace)
                            .padding(.trailing, AppStyle.layout.mediumSpace)
                            .hidden(!isFocused)
                    }
                }
            }

            if isShowErrorMessage() {
                errorMessageText
            }
        }
    }

    private func limitText(_ upper: Int) {
        if configurationData.text.wrappedValue.count > upper {
            configurationData.text.wrappedValue = String(configurationData.text.wrappedValue.prefix(upper))
        }
    }

    private func isShowErrorMessage() -> Bool {
        return configurationData.errorMessage?.isEmpty == false &&
            configurationData.showErrorMessage.wrappedValue
    }

    private func backgroundColorTextField() -> Color {
        return .clear
    }

    private func fillColor() -> Color {
        return configurationData.isDisable ? AppStyle.theme.tfFillDisableColor : AppStyle.theme.tfFillNormalColor
    }

    private func boderColor () -> Color {
        if configurationData.isDisable {
            return AppStyle.theme.tfBorderNormalColor
        }

        if isShowErrorMessage() {
            return AppStyle.theme.textErrorMessageColor
        }

        if isFocused {
            return AppStyle.theme.tfBorderActiveColor
        }

        return AppStyle.theme.tfBorderNormalColor
    }
}

private extension InputTextField {
    var titleNameText: some View {
        return Text(configurationData.titleName)
            .foregroundColor(AppStyle.theme.textNoteColor)
            .font(AppStyle.font.regular12)
    }
    var secureField: some View {
//        return SecureField(configurationData.placeHolder, text: configurationData.text, onCommit: {
//            isFocused = false
//        }).simultaneousGesture(TapGesture().onEnded {
//                isFocused = true
//        })
//        .textFieldStyle(.standard())
//            .background(backgroundColorTextField())
//            .disabled(configurationData.isDisable)

        return ZStack(alignment: .leading) {
            TextField(configurationData.placeHolder, text: configurationData.text) { editing in
                isFocused = editing
            }.textFieldStyle(.standard())
                .opacity(visibleText.isEmpty ? 1 : 0.010000001)
                .background(backgroundColorTextField())
                .disabled(configurationData.isDisable)
                .allowsHitTesting(true)
                .onAppear() {
                    visibleText = String(repeating: "•", count: configurationData.text.wrappedValue.count)
                }.onChange(of: configurationData.text.wrappedValue) { newValue in
                    visibleText = String(repeating: "•", count: newValue.count)
                }

            visibleTextView
        }
    }

    var visibleTextView: some View {
        return Text(visibleText)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(AppStyle.theme.textNormalColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(visibleText.isEmpty ? Color.clear : fillColor())
            .allowsHitTesting(false)
    }

    var hideSecureField: some View {
        return TextField(configurationData.placeHolder, text: configurationData.text, onEditingChanged: { editingChanged in
            isFocused = editingChanged
        }).textFieldStyle(.standard())
            .background(backgroundColorTextField())
            .disabled(configurationData.isDisable)
    }
    var textField: some View {
        return TextField(configurationData.placeHolder, text: configurationData.text, onEditingChanged: { editingChanged in
            isFocused = editingChanged
        }).textFieldStyle(.standard())
            .disabled(configurationData.isDisable)
    }
    var errorMessageText: some View {
        return Text(configurationData.errorMessage ?? "")
            .foregroundColor(AppStyle.theme.textErrorMessageColor)
            .font(AppStyle.font.regular14)
            .padding(.horizontal, AppStyle.layout.standardSpace)
            .multilineTextAlignment(.leading)
            .lineSpacing(AppStyle.layout.lineSpacing)
            .lineLimit(2)
    }
    var secureButton: some View {
        return Button {
            isShowPassword.toggle()
        } label: {
            Image(systemName: self.isShowPassword ? "eye.slash" : "eye")
                .resizable()
                .applyTheme(.ink300)
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 15)
                .hidden(configurationData.text.wrappedValue.isEmpty || configurationData.isDisable)
        }
    }
    var clearTextButton: some View {
        return Button {
            configurationData.text.wrappedValue = ""
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .applyTheme(.ink300)
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .hidden(configurationData.text.wrappedValue.isEmpty || configurationData.isDisable)
        }
    }
}
