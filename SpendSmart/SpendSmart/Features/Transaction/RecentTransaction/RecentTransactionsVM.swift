//
//  RecentTransactionsVM.swift
//  SpendSmart
//
//  Created by dtrognn on 11/04/2024.
//

import Foundation

class RecentTransactionsVM: BaseViewModel {
    @Published var transactions: [Transaction] = []
    @Published var timeType: RecentTransTimeType = .day

    private var dateSelectedDay: DateSelected
    private var dateSelectedMonth: DateSelected
    private var dateSelectedYear: DateSelected

    private let transactionManager = TransactionManager.shared

    override init() {
        let date = Date()
        self.dateSelectedDay = .init(day: date.day, month: date.month, year: date.year)
        self.dateSelectedMonth = .init(day: date.day, month: date.month, year: date.year)
        self.dateSelectedYear = .init(day: date.day, month: date.month, year: date.year)
    }

    func loadData() {
        apiGetTransWithCondition()
    }
}

extension RecentTransactionsVM {
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

extension RecentTransactionsVM {
    private func apiGetTransitionList() {
        showLoading(true)
        transactionManager.getTransactionList(type: .expense) { [weak self] result in
            switch result {
            case .success(let transactions):
                guard let self = self else { return }
                self.showLoading(false)
                self.transactions = transactions.sorted(by: { $0.createdAt > $1.createdAt })
            case .failure:
                self?.showLoading(false)
                print("AAA get transition error")
            }
        }
    }

    private func apiGetTransWithCondition() {
        let timeRange = getTimeRange()
        let fromTime = timeRange.fromTime
        let toTime = timeRange.toTime

        print("AAA from: \(fromTime) - to: \(toTime)")

        showLoading(true)
        transactionManager.getTransWithCondition(fromTime: fromTime, toTime: toTime) { [weak self] result in
            switch result {
            case .success(let trans):
                guard let self = self else { return }
                self.showLoading(false)
                self.transactions = trans
            case .failure(let failure):
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
