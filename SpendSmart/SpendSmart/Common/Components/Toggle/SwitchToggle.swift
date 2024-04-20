//
//  SwitchToggle.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

struct SwitchToggle: View {
    @Binding private var isOn: Bool
    var onSelect: ((Bool) -> Void)?

    init(isOn: Binding<Bool>, onSelect: ((Bool) -> Void)? = nil) {
        _isOn = isOn
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            isOn = !isOn
            onSelect?(isOn)
        } label: {
            Image(isOn ? "ic_switch_on" : "ic_switch_off")
                .applyTheme(isOn ? AppStyle.theme.iconOnColor : AppStyle.theme.iconOffColor)
                .padding(AppStyle.layout.standardSpace)
        }.frame(height: AppStyle.layout.standardButtonHeight)
    }
}
