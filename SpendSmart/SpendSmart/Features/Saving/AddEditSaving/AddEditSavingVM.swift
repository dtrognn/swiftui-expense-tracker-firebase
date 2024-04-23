//
//  AddEditSavingVM.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import Combine
import Foundation

class AddEditSavingVM: BaseViewModel {
    static let shared = AddEditSavingVM()

    @Published var amount: String = ""
    @Published var description: String = ""
    @Published var category: Category = .init()
    @Published var logs: [SavingLog] = []

    @Published var isShowTextField: Bool = false
    @Published var moreAmount: String = "0.0"

    var isEdit: Bool = false
    var onAddUpdateSuccess = PassthroughSubject<Void, Never>()

    private var saving: Saving?

    override init() {
        super.init()
    }

    func setParams(_ saving: Saving? = nil) {
        self.saving = saving
        self.isEdit = saving != nil

        self.amount = String(saving?.amount ?? 0.0)
        self.description = saving?.description ?? ""
        self.category = saving?.category ?? Category()
        self.logs = saving?.logs ?? []
    }

    func addEditSavings() {
        //
    }

    func addNewLog() {
        let newLog = SavingLog(amount: Double(self.moreAmount) ?? 0.0)
        self.logs.append(newLog)
        print("AAA \(newLog.createdAt) - \(newLog.amount)")
        self.isShowTextField = false
    }

    func updateCategory(_ category: Category) {
        self.category = category
    }
}
