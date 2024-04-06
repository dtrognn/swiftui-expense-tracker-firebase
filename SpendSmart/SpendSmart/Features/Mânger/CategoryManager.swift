//
//  CategoryManager.swift
//  SpendSmart
//
//  Created by dtrognn on 06/04/2024.
//

import Foundation

class CategoryManager: BaseViewModel {
    static let shared = CategoryManager()

    @Published var categories: [Category] = []

    private var authService = AuthServiceManager.shared

    func getCategories() {
        apiFetchCategoryList()
    }

    func addNewCategory(_ newCategory: Category, completion: @escaping (Result<Void, Error>) -> Void) {
        apiAddNewCategory(newCategory, completion: completion)
    }

    func updateCategory(_ category: Category, completion: @escaping (Result<Void, Error>) -> Void) {
        apiUpdateCagory(category, completion: completion)
    }

    func deleteCategory(_ categoryID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        apiDeleteCategory(categoryID, completion: completion)
    }

    private func apiFetchCategoryList() {
        guard let uid = authService.userSesstion?.uid else { return }

        FIRCategoryCollection
            .whereField("uid", isEqualTo: uid)
            .addSnapshotListener { querySnapshot, _ in
                guard let documents = querySnapshot?.documents else {
                    print("AAA No documents or an error occurred")
                    return
                }

                self.categories = documents.compactMap { document in
                    try? document.data(as: Category.self)
                }
            }
    }

    private func apiAddNewCategory(_ newCategory: Category, completion: @escaping (Result<Void, Error>) -> Void) {
        try? FIRCategoryCollection.document(newCategory.id).setData(newCategory.asDictionary()) { [weak self] error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))

                self?.categories.append(newCategory)
            }
        }
    }

    private func apiUpdateCagory(_ category: Category, completion: @escaping (Result<Void, Error>) -> Void) {
        try? FIRCategoryCollection.document(category.id).updateData(category.asDictionary()) { [weak self] error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))

                if let index = self?.categories.firstIndex(where: { $0.id == category.id }) {
                    self?.categories[index] = category
                }
            }
        }
    }

    private func apiDeleteCategory(_ categoryID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        FIRCategoryCollection.document(categoryID).delete { [weak self] error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))

                if let index = self?.categories.firstIndex(where: { $0.id == categoryID }) {
                    self?.categories.remove(at: index)
                }
            }
        }
    }
}
