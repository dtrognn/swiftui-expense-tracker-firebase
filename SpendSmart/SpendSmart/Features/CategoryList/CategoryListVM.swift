//
//  CategoryListVM.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import Foundation

class CategoryListVM: BaseViewModel {
    @Published var categories: [Category] = []

    private var categoryManager = CategoryManager.shared

    override init() {
        super.init()
        getData()
    }

    func getData(_ isLoading: Bool = false) {
        getCategoryList(isLoading)
    }

    private func getCategoryList(_ isLoading: Bool = false) {
        showLoading(isLoading)
        categoryManager.getCategories { [weak self] result in
            switch result {
            case .success(let categories):
                guard let self = self else { return }
                self.showLoading(false)
                self.categories = categories
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
