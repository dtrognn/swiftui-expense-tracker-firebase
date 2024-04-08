//
//  OptionEditView.swift
//  SpendSmart
//
//  Created by dtrognn on 08/04/2024.
//

import SwiftUI

struct OptionEditView: View {
    @State private var selectionAll: Bool
    @Binding private var numberItemSelected: Int
    private var onClose: (() -> Void)?
    private var onSelectAll: ((Bool) -> Void)?

    init(selectionAll: Bool = false, numberItemSelected: Binding<Int>, onClose: (() -> Void)? = nil, onSelectAll: ((Bool) -> Void)? = nil) {
        self.selectionAll = selectionAll
        self._numberItemSelected = numberItemSelected
        self.onClose = onClose
        self.onSelectAll = onSelectAll
    }

    var body: some View {
        HStack {
            cancelSelectionButton
            Spacer()
            titleSelectionText
            Spacer()
            selectAllButton
        }.padding(.vertical, AppStyle.layout.standardSpace)
            .background(AppStyle.theme.naviBackgroundColor)
    }
}

private extension OptionEditView {
    var selectAllButton: some View {
        return Button {
            selectionAll = !selectionAll
            onSelectAll?(selectionAll)
        } label: {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .applyTheme(selectionAll ? AppStyle.theme.iconHighlightColor : AppStyle.theme.iconNormalColor)
                .scaledToFit()
                .frame(width: 20, height: 20)
        }.frame(width: AppStyle.layout.standardButtonHeight)
    }

    var cancelSelectionButton: some View {
        return Button {
            onClose?()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .applyTheme()
                .frame(width: 16, height: 16)
                .frame(width: AppStyle.layout.standardSpace, height: AppStyle.layout.standardSpace)
        }.frame(width: AppStyle.layout.standardButtonHeight)
    }

    var titleSelectionText: some View {
        return Text(String(format: "%@ %d", language("SS_Common_A_07"), numberItemSelected))
            .foregroundColor(AppStyle.theme.naviTextColor)
            .font(AppStyle.font.semibold16)
    }
}
