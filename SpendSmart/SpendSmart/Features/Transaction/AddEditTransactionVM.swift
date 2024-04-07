//
//  AddEditTransactionVM.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import Combine
import Foundation

class AddEditTransactionVM: BaseViewModel {
    @Published var amount: String
    @Published var description: String
    @Published var isEdit: Bool

    init(_ transaction: Transaction?) {
        self.isEdit = transaction != nil
        self.amount = "\(transaction?.amount ?? 0)"
        self.description = transaction?.description ?? ""
    }
}
