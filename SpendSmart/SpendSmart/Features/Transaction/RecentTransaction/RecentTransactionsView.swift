//
//  RecentTransactionsView.swift
//  SpendSmart
//
//  Created by dtrognn on 11/04/2024.
//

import SwiftUI

struct RecentTransactionsView: View {
    @EnvironmentObject private var router: RecentTransactionsRouter
    @StateObject private var vm = RecentTransactionsVM()
    @State private var dateFormat: String = ""

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Recent_Transactions_A_01"),
            showBackButton: true,
            showNavibar: true,
            hidesBottomBarWhenPushed: true
        )
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppStyle.layout.standardSpace) {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        timeSegmentView
                        selectDateView
                    }

                    if vm.transactions.isEmpty {
                        noRecentTransView
                    } else {
                        LazyVStack(spacing: AppStyle.layout.standardSpace) {
                            ForEach(vm.transactions) { transaction in
                                TransactionItemView(transaction: transaction, onClick: { transactionSelected in
                                    router.push(to: .addEditTransaction(transactionSelected))
                                })
                                .applyShadowView()
                            }
                        }
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }.refreshable {
                updateData()
            }
        }.onAppear {
            updateData()
        }.onChange(of: vm.timeType) { _ in
            updateData()
        }
    }
}

private extension RecentTransactionsView {
    private func updateData() {
        updateDateFormat()
        vm.loadData()
    }

    private func updateDateFormat() {
        let dateSelected = vm.getDateSelecteBy()

        switch vm.timeType {
        case .day:
            dateFormat = String(format: "%d/%d/%d", dateSelected.day, dateSelected.month, dateSelected.year)
        case .month:
            dateFormat = String(format: "%@ %d/%d", language("Recent_Transactions_A_05"), dateSelected.month, dateSelected.year)
        case .year:
            dateFormat = String(format: "%d", dateSelected.year)
        }
    }

    var timeSegmentView: some View {
        return Picker("", selection: $vm.timeType) {
            ForEach(RecentTransTimeType.allCases) { type in
                Text(type.title)
                    .font(AppStyle.font.regular16)
                    .foregroundColor(AppStyle.theme.textNormalColor)
                    .tag(type)
            }
        }.pickerStyle(.segmented)
    }

    var selectDateView: some View {
        VStack(spacing: AppStyle.layout.zero) {
            HStack(spacing: AppStyle.layout.zero) {
                decreaseButton
                Spacer()
                datePickerButton
                Spacer()
                increaseButton
            }
        }.applyShadowView()
    }

    var datePickerButton: some View {
        Button {
            var dateType: DateType
            let dateSelected: DateSelected = vm.getDateSelecteBy()
            switch vm.timeType {
            case .day:
                dateType = .day
            case .month:
                dateType = .month
            case .year:
                dateType = .year
            }

            DatePickerView(dateDefault: dateSelected, dateType: dateType) { dateSelected in
                vm.updateDateSelected(dateSelected)
                updateData()
            }.show()
        } label: {
            Text(dateFormat)
                .font(AppStyle.font.medium16)
                .foregroundColor(AppStyle.theme.textNormalColor)
        }
    }

    var decreaseButton: some View {
        Button {
            vm.increaseAndDecreaseDateSelected(.decrease)
            updateData()
        } label: {
            Image("ic_arrow_right").applyTheme()
                .frame(width: AppStyle.layout.standardButtonHeight,
                       height: AppStyle.layout.standardButtonHeight)
                .rotationEffect(.init(degrees: -180))
        }
    }

    var increaseButton: some View {
        Button {
            vm.increaseAndDecreaseDateSelected(.increase)
            updateData()
        } label: {
            Image("ic_arrow_right").applyTheme()
                .frame(width: AppStyle.layout.standardButtonHeight,
                       height: AppStyle.layout.standardButtonHeight)
        }
    }
}

private extension RecentTransactionsView {
    var noRecentTransView: some View {
        return VStack(spacing: AppStyle.layout.standardSpace) {
            noRecentTransText
            addTransLargeButton
        }.padding(.top, AppStyle.layout.standardButtonHeight)
    }

    var addTransLargeButton: some View {
        return Button {
            Vibration.selection.vibrate()
            router.push(to: .addEditTransaction(nil))
        } label: {
            Text(language("Recent_Transactions_A_03"))
                .font(AppStyle.font.semibold16)
                .foregroundColor(AppStyle.theme.btTextEnableColor)
                .padding(.vertical, AppStyle.layout.mediumSpace)
                .padding(.horizontal, AppStyle.layout.standardSpace)
                .background(AppStyle.theme.btBackgroundEnableColor)
                .cornerRadius(AppStyle.layout.standardCornerRadius)
        }
    }

    var noRecentTransText: some View {
        return Text(language("Recent_Transactions_A_02"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
