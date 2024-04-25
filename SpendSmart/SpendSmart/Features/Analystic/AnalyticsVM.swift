//
//  AnalyticsVM.swift
//  SpendSmart
//
//  Created by dtrognn on 20/04/2024.
//

import Combine
import Foundation

class AnalyticsVM: BaseViewModel {
    @Published var chartDatas: [ChartData] = []
    @Published var timeType: RecentTransTimeType = .day
    @Published var transType: TransactionType = .expense
    @Published var chartType: ChartType = .bar

    private var transManager = TransactionManager.shared
    private var dateSelectedDay: DateSelected
    private var dateSelectedMonth: DateSelected
    private var dateSelectedYear: DateSelected

    var onGetDataSuccess = PassthroughSubject<Void, Never>()

    override init() {
        let date = Date()
        self.dateSelectedDay = .init(day: date.day, month: date.month, year: date.year)
        self.dateSelectedMonth = .init(day: date.day, month: date.month, year: date.year)
        self.dateSelectedYear = .init(day: date.day, month: date.month, year: date.year)
    }

    override func initData() {
        loadData()
    }

    func loadData() {
        apiGetTransWithCondition()
    }
}

extension AnalyticsVM {
    func getDateSelecteBy() -> DateSelected {
        switch timeType {
        case .day:
            return dateSelectedDay
        case .month:
            return dateSelectedMonth
        case .year:
            return dateSelectedYear
        }
    }

    func updateDateSelected(_ dateSelected: DateSelected) {
        switch timeType {
        case .day:
            dateSelectedDay = dateSelected
        case .month:
            dateSelectedMonth = dateSelected
        case .year:
            dateSelectedYear = dateSelected
        }
    }

    func increaseAndDecreaseDateSelected(_ type: RTChangeTimeType) {
        let calendar = Calendar.current

        switch timeType {
        case .day, .month:
            let component: Calendar.Component = (timeType == .day) ? .day : .month
            let changeValue: Int = (type == .increase) ? 1 : -1
            let dateSelected = getDateSelecteBy()

            let components = DateComponents(year: dateSelected.year, month: dateSelected.month, day: dateSelected.day)

            if let newDate = calendar.date(byAdding: component, value: changeValue, to: calendar.date(from: components) ?? Date()) {
                let newComponents = calendar.dateComponents([.year, .month, .day], from: newDate)

                if timeType == .day {
                    dateSelectedDay = DateSelected(day: newComponents.day ?? 1, month: newComponents.month ?? 1, year: newComponents.year ?? 2000)
                } else {
                    dateSelectedMonth = DateSelected(day: newComponents.day ?? 1, month: newComponents.month ?? 1, year: newComponents.year ?? 2000)
                }
            }
        case .year:
            dateSelectedYear.year += (type == .increase) ? 1 : -1
        }
    }

    private func getTimeRange() -> RTTimeRange {
        let dateSelect = getDateSelecteBy()
        let calendar = Calendar.current
        var fromTime = Date()
        var toTime = Date()

        let dateComponent = DateComponents(year: dateSelect.year, month: dateSelect.month, day: dateSelect.day)
        let selectedDate = calendar.date(from: dateComponent) ?? Date()

        switch timeType {
        case .day:
            fromTime = calendar.startOfDay(for: selectedDate)
            toTime = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: selectedDate) ?? Date()
        case .month:
            fromTime = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)) ?? Date()
            toTime = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: fromTime) ?? Date()
            toTime = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: toTime) ?? Date()
        case .year:
            fromTime = calendar.date(from: calendar.dateComponents([.year], from: selectedDate)) ?? Date()
            toTime = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: fromTime) ?? Date()
            toTime = calendar.date(bySettingHour: 23, minute: 59, second: 50, of: toTime) ?? Date()
        }

        return RTTimeRange(fromTime: fromTime.timeIntervalSince1970, toTime: toTime.timeIntervalSince1970)
    }
}

// MARK: - Handle API

extension AnalyticsVM {
    private func apiGetTransWithCondition() {
        let timeRange = getTimeRange()
        let fromTime = timeRange.fromTime
        let toTime = timeRange.toTime

        showLoading(true)
        transManager.getTransWithCondition(type: transType, fromTime: fromTime, toTime: toTime) { [weak self] result in
            switch result {
            case .success(let trans):
                guard let self = self else { return }
                self.showLoading(false)
                self.handleFilterData(trans)
                self.onGetDataSuccess.send(())
            case .failure(let failure):
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }

    private func handleFilterData(_ transaction: [Transaction]) {
        var categoryGroup: [CategoryGroupData] = []

        transaction.forEach { tran in
            if let index = categoryGroup.firstIndex(where: { $0.category.id == tran.category.id }) {
                categoryGroup[index].amount.append(tran.amount)
            } else {
                categoryGroup.append(CategoryGroupData(category: tran.category, amount: [tran.amount]))
            }
        }

        handleCalcChartData(categoryGroup)
    }

    private func handleCalcChartData(_ datas: [CategoryGroupData]) {
        let chartDatas = datas.map {
            let x = $0.category
            let y = $0.amount.reduce(0.0, +)
            return ChartData(type: x, count: y)
        }
        self.chartDatas = chartDatas
    }
}
