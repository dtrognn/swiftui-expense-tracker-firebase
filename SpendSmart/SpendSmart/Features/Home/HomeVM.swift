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
    @Published var transitions: [Transaction] = []

    private let authService = AuthServiceManager.shared
    private let transactionManager = TransactionManager.shared

    override func loadData() {
        apiGetUserInfo()
        apiGetTransitionList()
    }

    private func apiGetUserInfo() {
        authService.getUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                guard let user = user else { return }
                self?.username = user.fullname
            case .failure(let failure):
                print("AAA get user failed: \(failure.localizedDescription)")
            }
        }
    }
}

extension HomeVM {
    func apiGetTransitionList() {
        transactionManager.getTransactionList(type: .expense) { [weak self] result in
            switch result {
            case .success(let transitions):
                self?.transitions = transitions

                self?.transitions.forEach { t in
                    print("AAA amount: \(t.amount) - type: \(t.type) - timestamp: \(t.createdAt)")
                }
            case .failure(let failure):
                print("AAA get transition error")
            }
        }
    }
}
