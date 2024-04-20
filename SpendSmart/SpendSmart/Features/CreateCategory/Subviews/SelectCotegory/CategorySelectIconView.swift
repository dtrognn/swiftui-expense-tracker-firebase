//
//  CategorySelectIconView.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import SwiftUI

struct CategorySelectIconView: View {
    private var selectedColor: CategoryColor
    private var selectedIcon: CategoryIcon
    private var onUpdateHeight: ((CGFloat) -> Void)?
    private var onSelect: ((CategoryIcon) -> Void)?

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: AppStyle.layout.standardSpace), count: 6)

    init(selectedColor: CategoryColor,
         selectedIcon: CategoryIcon,
         onUpdateHeight: ((CGFloat) -> Void)? = nil,
         onSelect: ((CategoryIcon) -> Void)? = nil)
    {
        self.selectedColor = selectedColor
        self.selectedIcon = selectedIcon
        self.onUpdateHeight = onUpdateHeight
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(spacing: AppStyle.layout.standardSpace) {
            titleText.padding(.top, AppStyle.layout.hugeSpace)
            iconGridView
            Spacer()
        }.background(AppStyle.theme.backgroundColor)
            .background(
            GeometryReader { proxy in
                Color.clear.onAppear {
                    onUpdateHeight?(proxy.size.height)
                }
            }
        )
    }
}

private extension CategorySelectIconView {
    var titleText: some View {
        return Text(language("Add_Edit_Category_A_05"))
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var iconGridView: some View {
        return LazyVGrid(columns: columns, spacing: AppStyle.layout.standardSpace) {
            ForEach(CategoryIcon.allCases, id: \.self) { icon in
                CategorySelectIconItemView(bgColor: selectedColor, icon: icon, selectedIcon: selectedIcon) { selectedIcon in
                    onSelect?(selectedIcon)
                }
            }
        }
    }
}
