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
    @Published var unit: Unit = .vnd
    @Published var transactionType: TransactionType = .expense
    @Published var category: Category = .init()
    @Published var description: String = ""
    @Published var dateSelected: DateSelected = .init(day: 1, month: 1, year: 2024)
    @Published var dateSelectedString: String = ""

    var onAddEditTransitionSuccess = PassthroughSubject<Void, Never>()

    private var authService = AuthServiceManager.shared
    private var transactionManager = TransactionManager.shared

    override init() {
        super.init()
    }

    func setParams(_ transaction: Transaction?) {
        self.isEdit = transaction != nil
        self.amount = "\(transaction?.amount ?? 0)"
        self.unit = transaction?.tUnit ?? .vnd
        self.transactionType = transaction?.transactionType ?? .expense
        self.category = transaction?.category ?? Category()
        self.description = transaction?.description ?? ""

        let date = Date(timeIntervalSince1970: transaction?.createdAt ?? Date().timeIntervalSince1970)
        self.dateSelected = DateSelected(day: date.day, month: date.month, year: date.year)

        self.handleUpdateDateSelected(self.dateSelected)
    }

    func addUpdateTransaction() {
        if self.isEdit {
            // TODO: -
        } else {
            apiAddTransaction()
        }
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

extension AddEditTransactionVM {
    private func apiAddTransaction() {
        guard let uid = authService.userSesstion?.uid else { return }
        let newTransaction = Transaction(uid: uid,
                                         description: description,
                                         type: transactionType.rawValue,
                                         amount: Double(self.amount) ?? 0,
                                         unit: unit,
                                         category: self.category,
                                         createdAt: self.dateSelected.toDate.timeIntervalSince1970)

        showLoading(true)
        self.transactionManager.addTransaction(newTransaction) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.showSuccessMessage(language("SS_Common_A_02"))
                self.onAddEditTransitionSuccess.send(())
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
