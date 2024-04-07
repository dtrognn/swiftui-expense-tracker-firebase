//
//  AddEditTransactionVM.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import Combine
import Foundation

class AddEditTransactionVM: BaseViewModel {
    @Published var isEdit: Bool
    @Published var amount: String
    @Published var description: String
    @Published var dateSelected: DateSelected
    @Published var dateSelectedString: String = ""

    init(_ transaction: Transaction?) {
        self.isEdit = transaction != nil
        self.amount = "\(transaction?.amount ?? 0)"
        self.description = transaction?.description ?? ""

        let date = Date(timeIntervalSince1970: transaction?.createdAt ?? Date().timeIntervalSince1970)
        self.dateSelected = DateSelected(day: date.day, month: date.month, year: date.year)

        super.init()
        self.handleUpdateDateSelected(self.dateSelected)
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
