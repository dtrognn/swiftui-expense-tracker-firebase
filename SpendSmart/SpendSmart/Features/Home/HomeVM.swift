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
    @Published var chartDatas: [ChartData] = []
    @Published var chartType: ChartType = .bar

    private let authService = AuthServiceManager.shared
    private let transactionManager = TransactionManager.shared

    override func makeSubscription() {
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
    private func apiGetTransitionList() {
        transactionManager.getTransactionList(type: .expense) { [weak self] result in
            switch result {
            case .success(let transactions):
                guard let self = self else { return }
                self.transactions = transactions.sorted(by: { $0.createdAt < $1.createdAt })
                self.handleFilterData(transactions)
            case .failure:
                print("AAA get transition error")
            }
        }
    }

    private func handleFilterData(_ transaction: [Transaction]) {
        var categoryGroup: [CategoryGroupData] = []

        transaction.forEach { tran in
            if let index = categoryGroup.firstIndex(where: { $0.category.id == tran.category.id }) {
                categoryGroup[index].amount.append(tran.amount)
            } else {
                categoryGroup.append(CategoryGroupData(category: tran.category, amount: [tran.amount]))
            }
        }

        categoryGroup.forEach { c in
            print("AAA \(c.category.name) - \(c.amount)")
        }

        handleCalcChartData(categoryGroup)
    }

    private func handleCalcChartData(_ datas: [CategoryGroupData]) {
        let chartDatas = datas.map {
            let x = $0.category
            let y = $0.amount.reduce(0.0, +)
            return ChartData(type: x, count: y)
        }
        self.chartDatas = chartDatas
    }
}
