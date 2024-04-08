//
//  AddEditTransactionVM.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import Combine
import Foundation

class AddEditTransactionVM: BaseViewModel {
    static let shared = AddEditTransactionVM()

    @Published var isEdit: Bool = false
    @Published var amount: String = "0"
    @Published var category: Category = .init()
    @Published var description: String = ""
    @Published var dateSelected: DateSelected = .init(day: 1, month: 1, year: 2024)
    @Published var dateSelectedString: String = ""

    override init() {
        super.init()
    }

    func setParams(_ transaction: Transaction?) {
        self.isEdit = transaction != nil
        self.amount = "\(transaction?.amount ?? 0)"
        self.category = transaction?.category ?? Category()
        self.description = transaction?.description ?? ""

        let date = Date(timeIntervalSince1970: transaction?.createdAt ?? Date().timeIntervalSince1970)
        self.dateSelected = DateSelected(day: date.day, month: date.month, year: date.year)

        self.handleUpdateDateSelected(self.dateSelected)
    }

    func updateCategory(_ category: Category) {
        self.category = category
    }

    func handleUpdateDateSelected(_ dateSelected: DateSelected) {
        let dateSelectedTimestamp = dateSelected.toDate.timeIntervalSince1970

        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let currentDateTimestamp = startOfDay.timeIntervalSince1970

        if dateSelectedTimestamp > currentDateTimestamp {
            self.updateDateSelected(DateSelected(day: startOfDay.day, month: startOfDay.month, year: startOfDay.year))
        } else {
            self.updateDateSelected(dateSelected)
        }
    }

    private func updateDateSelected(_ dateSelected: DateSelected) {
        self.dateSelected = dateSelected
        self.dateSelectedString = String(format: "%02d/%02d/%02d", dateSelected.day, dateSelected.month, dateSelected.year)
    }
}
