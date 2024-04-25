//
//  SavingVM.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import Foundation

class SavingVM: BaseViewModel {
    @Published var savings: [Saving] = []

    private var savingManager = SavingManager.shared

    override func initData() {
        loadData()
    }

    func loadData() {
        apiGetSavings()
    }

    private func apiGetSavings() {
        savingManager.getSavingList { [weak self] result in
            switch result {
            case .success(let savings):
                guard let self = self else { return }
                self.savings = savings
            case .failure(let error):
                guard let self = self else { return }
                self.showErrorMessage(error.localizedDescription)
            }
        }
    }
}
