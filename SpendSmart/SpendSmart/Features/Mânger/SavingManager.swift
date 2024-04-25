//
//  SavingManager.swift
//  SpendSmart
//
//  Created by dtrognn on 23/04/2024.
//

import Foundation

class SavingManager: BaseViewModel {
    static let shared = SavingManager()

    private let authService = AuthServiceManager.shared

    func getSavingList(completion: @escaping (Result<[Saving], Error>) -> Void) {
        apiGetSavingList(completion: completion)
    }

    func addNewSaving(_ newSaving: Saving, completion: @escaping (Result<Void, Error>) -> Void) {
        apiAddNewSaving(newSaving, completion: completion)
    }

    func updateSaving(_ saving: Saving, completion: @escaping (Result<Void, Error>) -> Void) {
        apiUpdateSaving(saving, completion: completion)
    }

    private func apiGetSavingList(completion: @escaping (Result<[Saving], Error>) -> Void) {
        guard let uid = authService.userSesstion?.uid else { return }

        FIRSavingCollection
            .whereField("uid", isEqualTo: uid)
            .getDocuments { [weak self] snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let snapshot = snapshot else {
                    completion(.failure(NSError(domain: "Snapshot is nil", code: -1, userInfo: nil)))
                    return
                }

                let savings = snapshot.documents.compactMap { document in
                    try? document.data(as: Saving.self)
                }
                completion(.success(savings))
            }
    }

    private func apiAddNewSaving(_ newSaving: Saving, completion: @escaping (Result<Void, Error>) -> Void) {
        try? FIRSavingCollection.document(newSaving.id)
            .setData(newSaving.asDictionary()) { [weak self] error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
    }

    private func apiUpdateSaving(_ saving: Saving, completion: @escaping (Result<Void, Error>) -> Void) {
        try? FIRSavingCollection.document(saving.id)
            .updateData(saving.asDictionary(), completion: { [weak self] error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            })
    }
}
