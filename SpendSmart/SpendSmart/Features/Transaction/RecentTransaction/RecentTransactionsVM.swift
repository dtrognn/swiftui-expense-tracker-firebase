//
//  RecentTransactionsVM.swift
//  SpendSmart
//
//  Created by dtrognn on 11/04/2024.
//

import Foundation

class RecentTransactionsVM: BaseViewModel {
    @Published var transactions: [Transaction] = []

    private let transactionManager = TransactionManager.shared

    override func makeSubscription() {
        apiGetTransitionList()
    }

    func loadData() {
        apiGetTransitionList()
    }

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
}
