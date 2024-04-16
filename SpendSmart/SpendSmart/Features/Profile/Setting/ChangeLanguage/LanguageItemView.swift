//
//  LanguageItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import SwiftUI

struct LanguageItemData: Identifiable {
    var id: String = UUID().uuidString
    var leftImage: Image?
    var title: String = ""
    var value: LanguageCode = .system
    var isSelected: Bool = false
    var onSelect: (LanguageCode) -> Void
}

struct LanguageItemView: View {
    var data: LanguageItemData

    var body: some View {
        Button {
            data.onSelect(data.value)
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                HStack(spacing: AppStyle.layout.standardSpace) {
                    data.leftImage?.resizable()
                        .frame(width: 32, height: 32)
                    Text(data.title)
                        .foregroundColor(AppStyle.theme.textNormalColor)
                        .font(AppStyle.font.regular16)
                        .padding(.trailing, AppStyle.layout.standardSpace)
                    Spacer()
                    Image(systemName: "checkmark")
                        .resizable()
                        .applyTheme()
                        .frame(width: 16, height: 14)
                        .hidden(!data.isSelected)
                }.padding(.vertical, AppStyle.layout.standardSpace)
                StraightLine()
            }.padding(.horizontal, AppStyle.layout.standardSpace)
        }.background(AppStyle.theme.rowCommonBackgroundColor)
    }
}
