//
//  CategoryListVM.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import Combine
import Foundation

// note:
// bo xung case check categorySelected from transaction == categoryDeleteSelected thi khong cho xoa

enum CategoryAlertType {
    case deleteNormal
    case deleteCategorySelectedFromTransaction
}

enum CategoryActionType {
    case update
    case select
}

class CategoryListVM: BaseViewModel {
    @Published var categories: [Category] = []
    @Published var showOptionSelect: Bool = false
    @Published var numberOfItemSelected: Int = 0
    @Published var actionType: CategoryActionType

    var addEditTransitionVM = AddEditTransactionVM.shared
    var categorySelected: Category?
    private var categoryManager = CategoryManager.shared

    init(_ actionType: CategoryActionType) {
        self.actionType = actionType
        super.init()
    }

    override func makeSubscription() {
        getData()
    }

    func getData(_ isLoading: Bool = false) {
        getCategoryList(isLoading)
    }

    func deleteCategory() {
        apiDeleteCategory()
    }

    func updateCategorySeleted(_ categorySelected: Category) {
        addEditTransitionVM.updateCategory(categorySelected)
    }
}

// MARK: - Handle option select

// not use

extension CategoryListVM {
    func enableModeSelect(_ isEnable: Bool) {
        numberOfItemSelected = 0
        categories.forEach { category in
            category.isSelected = false
            category.showOptionSelect = isEnable
        }
    }

    func selectAll(_ isSelectAll: Bool) {
        categories.forEach { category in
            category.isSelected = isSelectAll
            category.showOptionSelect = true
        }
        updateCountItemSelected()
    }

    private func subcribeCategory() {
        categories.forEach { category in
            category.onValueChanged = { [weak self] _ in
                self?.updateCountItemSelected()
            }
        }
    }

    private func updateCountItemSelected() {
        numberOfItemSelected = categories.filter { $0.isSelected }.count
    }

    private func reloadView() {
        showOptionSelect = false
        enableModeSelect(false)
    }
}

// MARK: - Handle API

extension CategoryListVM {
    private func getCategoryList(_ isLoading: Bool = false) {
        showLoading(isLoading)
        categoryManager.getCategories { [weak self] result in
            switch result {
            case .success(let categories):
                guard let self = self else { return }
                self.showLoading(false)
                self.categories = categories
                self.subcribeCategory()
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }

    private func apiDeleteCategory() {
        guard let categorySelected = categorySelected else { return }

        categoryManager.deleteCategory(categorySelected.id) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.showSuccessMessage(language("SS_Common_A_02"))
                if let index = categories.firstIndex(where: { $0.id == categorySelected.id }) {
                    self.categories.remove(at: index)
                }
                self.categorySelected = nil
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
