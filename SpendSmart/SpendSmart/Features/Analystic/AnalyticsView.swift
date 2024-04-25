//
//  SearchView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct AnalyticsView: View {
    @StateObject private var vm = AnalyticsVM()
    @State private var dateFormat: String = ""

    private var screenConfiguration: ScreenConfiguration {
        return ScreenConfiguration(
            title: language("Analystic_A_01"),
            showBackButton: false,
            showNavibar: true,
            hidesBottomBarWhenPushed: false)
    }

    var body: some View {
        ScreenContainerView(screenConfiguration) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: AppStyle.layout.standardSpace) {
                    VStack(spacing: AppStyle.layout.standardSpace) {
                        timeSegmentView
                        selectDateView
                    }

                    VStack(spacing: AppStyle.layout.zero) {
                        tranTransactionsView
                        if vm.chartDatas.isEmpty {
                            noRecentTransText
                        } else {
                            chartView()
                        }
                    }
                }.padding(.all, AppStyle.layout.standardSpace)
            }.refreshable {
                updateData()
            }
        }.onChange(of: vm.timeType) { _ in
            updateData()
        }.onReceive(vm.onGetDataSuccess) { _ in
            updateDateFormat()
        }
    }
}

private extension AnalyticsView {
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
            dateFormat = String(format: "%@ %d/%d", language("Analystic_A_04"), dateSelected.month, dateSelected.year)
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
        }.background(AppStyle.theme.rowCommonBackgroundColor)
            .cornerRadius(AppStyle.layout.standardCornerRadius)
            .applyShadowView()
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

    var noRecentTransText: some View {
        return Text(language("Analystic_A_02"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
            .padding(.top, AppStyle.layout.standardButtonHeight)
    }
}

// MARK: - Charts

private extension AnalyticsView {
    var tranTransactionsView: some View {
        return HStack {
            trackTransactionsText
            Spacer()
            selectChartTypeButton
        }
    }

    @ViewBuilder
    func chartView() -> some View {
        switch vm.chartType {
        case .line:
            EmptyView().asAnyView
        case .bar:
            barChartView.asAnyView
        case .pie:
            pieChartView.asAnyView
        }
    }

    var barChartView: some View {
        return BarChartView(configuration: BarChartConfiguration(
            data: vm.chartDatas,
            height: 300))
            .padding(.horizontal, AppStyle.layout.standardSpace)
    }

    var pieChartView: some View {
        return PieChartView(PieChartConfiguration(datas: vm.chartDatas))
    }

    var selectChartTypeButton: some View {
        return MenuView(selectChartTypeMenuConfiguration) {
            vm.chartType.icon
                .frame(width: AppStyle.layout.hugeSpace, height: AppStyle.layout.standardButtonHeight)
        }
    }

    var selectChartTypeMenuConfiguration: MenuConfiguration {
        return MenuConfiguration(menuItemList: chartMenuConfigurationList) { menu in
            didSelectChartTypeMenu(menu)
        }
    }

    var chartMenuConfigurationList: [MenuItemConfiguration] {
        return ChartType.allCases.map {
            MenuItemConfiguration(title: $0.title, trailingImage: $0.icon, data: $0)
        }
    }

    func didSelectChartTypeMenu(_ menu: MenuItemConfiguration) {
        guard let type = menu.data as? ChartType else { return }
        vm.chartType = type
    }

    var trackTransactionsText: some View {
        return Text(language("Analystic_A_03"))
            .font(AppStyle.font.semibold16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
