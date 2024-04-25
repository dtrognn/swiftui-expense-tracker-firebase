//
//  HomeVM.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import FirebaseAuth
import Foundation

class HomeVM: BaseViewModel {
    @Published var username: String = ""
    @Published var transactions: [Transaction] = []
    @Published var transType: TransactionType = .expense
    @Published var chartDatas: [ChartData] = []
    @Published var chartType: ChartType = .bar

    private let authService = AuthServiceManager.shared
    private let transactionManager = TransactionManager.shared

    override func makeSubscription() {
        apiGetUserInfo()
        apiGetTransitionList()
    }

    func loadData() {
        apiGetTransitionList()
    }

    private func apiGetUserInfo() {
        authService.getUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                guard let user = user else { return }
                self?.username = user.fullname
                UserDataManager.shared.saveUserInfo(user)
            case .failure(let failure):
                print("AAA get user failed: \(failure.localizedDescription)")
            }
        }
    }
}

extension HomeVM {
    private func apiGetTransitionList() {
        showLoading(true)
        transactionManager.getTransactionList(type: transType) { [weak self] result in
            switch result {
            case .success(let transactions):
                guard let self = self else { return }
                self.showLoading(false)
                self.transactions = transactions.sorted(by: { $0.createdAt < $1.createdAt })
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
                print("AAA get transition error")
            }
        }
    }
}
