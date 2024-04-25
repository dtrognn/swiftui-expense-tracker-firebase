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
    private var authService = AuthServiceManager.shared
    private var savingsManager = SavingManager.shared

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
        if self.isEdit {
            apiUpdateSaving()
        } else {
            apiAddNewSavings()
        }
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

extension AddEditSavingVM {
    private func apiAddNewSavings() {
        guard let uid = authService.userSesstion?.uid else { return }
        let newSaving = Saving(uid: uid,
                               amount: Double(amount) ?? 0.0,
                               category: category,
                               description: description,
                               logs: logs)

        showLoading(true)
        self.savingsManager.addNewSaving(newSaving) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.showSuccessMessage(language("SS_Common_A_02"))
                self.onAddUpdateSuccess.send(())
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }

    private func apiUpdateSaving() {
        guard let saving = self.saving else { return }
        let savingUpdated = Saving(id: saving.id,
                                   uid: saving.uid,
                                   amount: saving.amount,
                                   category: saving.category,
                                   description: self.description,
                                   createdAt: saving.createdAt,
                                   lastUpdate: Date().timeIntervalSince1970,
                                   logs: self.logs)

        showLoading(true)
        self.savingsManager.updateSaving(savingUpdated) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.showSuccessMessage(language("SS_Common_A_02"))
                self.onAddUpdateSuccess.send(())
            case .failure(let error):
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
