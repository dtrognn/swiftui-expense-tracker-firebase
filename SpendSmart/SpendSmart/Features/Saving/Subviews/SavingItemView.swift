//
//  SavingItemView.swift
//  SpendSmart
//
//  Created by dtrognn on 25/04/2024.
//

import SwiftUI

struct SavingItemView: View {
    private var saving: Saving
    private var onClick: ((Saving) -> Void)?

    @State private var currentValue: Double = 0.0
    @State private var sliderWidth: CGFloat = 0.0

    init(saving: Saving, onClick: ((Saving) -> Void)? = nil) {
        self.saving = saving
        self.onClick = onClick

        self.currentValue = saving.getCurrentSavingAmounts()
    }

    var body: some View {
        Button {
            Vibration.selection.vibrate()
            onClick?(saving)
        } label: {
            VStack(spacing: AppStyle.layout.zero) {
                VStack(alignment: .leading, spacing: AppStyle.layout.standardSpace) {
                    HStack(spacing: AppStyle.layout.zero) {
                        HStack(spacing: AppStyle.layout.standardSpace) {
                            iconImage
                            titleText
                        }
                        Spacer()
                        getStateView()
                    }

                    VStack(spacing: AppStyle.layout.smallSpace) {
                        percentageText
                        HStack(alignment: .bottom, spacing: AppStyle.layout.smallSpace) {
                            currentSavingAmountText
                            sliderView
                            amountText
                        }
                    }

                    lastUpdateText
                }.padding(.all, AppStyle.layout.standardSpace)
            }.background(AppStyle.theme.rowCommonBackgroundColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
                .applyShadowView()
        }
    }
}

private extension SavingItemView {
    var sliderView: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                sliderRectBGView
                progressRectView
            }.onAppear {
                sliderWidth = proxy.size.width
            }
        }.padding(.top, AppStyle.layout.smallSpace)
    }

    @ViewBuilder
    func getStateView() -> some View {
        let state = saving.getState()
        Text(state.title)
            .font(AppStyle.font.semibold16)
            .foregroundColor(state.color)
    }

    var progressRectView: some View {
        return RoundedRectangle(cornerRadius: AppStyle.layout.standardCornerRadius)
            .fill(AppStyle.theme.iconHighlightColor)
            .frame(width: getProgressWidth(), height: 10)
    }

    func getProgressWidth() -> CGFloat {
        let percentage = saving.getPercentageSuccess()
        return percentage * sliderWidth
    }

    var sliderRectBGView: some View {
        return RoundedRectangle(cornerRadius: AppStyle.layout.standardCornerRadius)
            .fill(AppStyle.theme.iconOffColor)
            .frame(width: sliderWidth, height: 10)
    }

    var percentageText: some View {
        return Text(String(format: "%d%@", Int(saving.getPercentageSuccess() * 100), "%"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textHightlightColor)
    }

    var titleText: some View {
        return Text(saving.category.name)
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var iconImage: some View {
        return saving.category.getIcon().image
    }

    var amountText: some View {
        return Text(saving.formattedAmount)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textHightlightColor)
    }

    var currentSavingAmountText: some View {
        return Text(saving.formattedCurrentSavingAmount)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textHightlightColor)
    }

    var lastUpdateText: some View {
        return Text(String(format: "%@: %@", language("Saving_A_06"), saving.getLastUpdate()))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNoteColor)
    }
}
