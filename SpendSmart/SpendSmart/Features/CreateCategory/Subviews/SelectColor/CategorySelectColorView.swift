//
//  CategorySelectColorView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct CategorySelectColorView: View {
    private var selectedColor: CategoryColor
    private var onUpdateHeight: ((CGFloat) -> Void)?
    private var onSelect: ((CategoryColor) -> Void)?

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: AppStyle.layout.standardSpace), count: 6)

    init(selectedColor: CategoryColor, onUpdateHeight: ((CGFloat) -> Void)? = nil, onSelect: ((CategoryColor) -> Void)? = nil) {
        self.selectedColor = selectedColor
        self.onUpdateHeight = onUpdateHeight
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(spacing: AppStyle.layout.standardSpace) {
            titleText.padding(.top, AppStyle.layout.hugeSpace)
            colorGridView
            Spacer()
        }.background(
            GeometryReader { proxy in
                Color.clear.onAppear {
                    onUpdateHeight?(proxy.size.height)
                }
            }
        )
    }
}

private extension CategorySelectColorView {
    var titleText: some View {
        return Text(language("Create_Category_A_04"))
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var colorGridView: some View {
        return LazyVGrid(columns: columns, spacing: AppStyle.layout.standardSpace) {
            ForEach(CategoryColor.allCases) { color in
                CategorySelectColorItemView(color: color, selectedColor: selectedColor) { selectedColor in
                    onSelect?(selectedColor)
                }
            }
        }
    }
}
