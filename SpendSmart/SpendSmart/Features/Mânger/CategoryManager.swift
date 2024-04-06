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
}
