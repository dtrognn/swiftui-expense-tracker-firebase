//
//  CategorySelectColorItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

struct CategorySelectColorItemView: View {
    private var color: CategoryColor
    private var selectedColor: CategoryColor
    private var onSelect: ((CategoryColor) -> Void)?

    private let circleWidth: CGFloat = 40
    private let circleStrokeWidth: CGFloat = 50

    init(color: CategoryColor, selectedColor: CategoryColor, onSelect: ((CategoryColor) -> Void)? = nil) {
        self.color = color
        self.selectedColor = selectedColor
        self.onSelect = onSelect
    }

    var body: some View {
        Button {
            onSelect?(color)
        } label: {
            Circle()
                .frame(width: circleWidth, height: circleWidth)
                .foregroundColor(color.color)
                .background(
                    Circle()
                        .stroke(selectedColor == color ? selectedColor.color : Color.clear, lineWidth: 2)
                        .frame(width: circleStrokeWidth, height: circleStrokeWidth)
                )
        }
    }
}
