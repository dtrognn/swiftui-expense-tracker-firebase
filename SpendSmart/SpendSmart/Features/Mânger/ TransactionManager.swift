//
//   TransactionManager.swift
//  SpendSmart
//
//  Created by dtrognn on 08/04/2024.
//

import Foundation

class TransactionManager: BaseViewModel {
    static let shared = TransactionManager()

    private var authService = AuthServiceManager.shared

    func getTransactionList(type: TransactionType, completion: @escaping (Result<[Transaction], Error>) -> Void) {
        apiGetTransactionList(type: type.rawValue, completion: completion)
    }

    func addTransaction(_ newTransaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        apiAddTransaction(newTransaction, completion: completion)
    }

    func updateTransaction(_ transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        apiUpdateTransaction(transaction, completion: completion)
    }

    func deleteTransaction(_ transactionID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        apiDeleteTransaction(transactionID, completion: completion)
    }

    func getTransWithCondition(type: TransactionType = .expense, fromTime: Double, toTime: Double, completion: @escaping (Result<[Transaction], Error>) -> Void) {
        apiGetTransWithCondition(type: type.rawValue, fromTime: fromTime, toTime: toTime, completion: completion)
    }

    private func apiGetTransactionList(type: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
        guard let uid = authService.userSesstion?.uid else { return }

        FIRTransactionsCollection
            .whereField("uid", isEqualTo: uid)
            .whereField("type", isEqualTo: type)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    completion(.failure(error))
                }

                guard let snapshot = snapshot else {
                    completion(.failure(NSError(domain: "Snapshot is nil", code: -1, userInfo: nil)))
                    return
                }

                let transactions = snapshot.documents.compactMap { document in
                    try? document.data(as: Transaction.self)
                }
                completion(.success(transactions))
            }
    }

    private func apiAddTransaction(_ newTransaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        try? FIRTransactionsCollection.document(newTransaction.id)
            .setData(newTransaction.asDictionary()) { [weak self] error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }

    private func apiUpdateTransaction(_ transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        try? FIRTransactionsCollection.document(transaction.id)
            .updateData(transaction.asDictionary(), completion: { [weak self] error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
    }

    private func apiDeleteTransaction(_ transactionID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        FIRTransactionsCollection.document(transactionID)
            .delete { [weak self] error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }

    private func apiGetTransWithCondition(type: String, fromTime: Double, toTime: Double, completion: @escaping (Result<[Transaction], Error>) -> Void) {
        guard let uid = authService.userSesstion?.uid else { return }

        let fromTimeInt = Int(fromTime)
        let toTimeInt = Int(toTime)

        FIRTransactionsCollection
            .whereField("uid", isEqualTo: uid)
            .whereField("type", isEqualTo: type)
            .whereField("created_at", isGreaterThanOrEqualTo: fromTimeInt)
            .whereField("created_at", isLessThanOrEqualTo: toTimeInt)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("AAA error: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }

                guard let snapshot = snapshot else {
                    completion(.failure(NSError(domain: "Snapshot is nil", code: -1, userInfo: nil)))
                    return
                }

                let transactions = snapshot.documents.compactMap { document in
                    try? document.data(as: Transaction.self)
                }
                completion(.success(transactions))
            }
    }
}
