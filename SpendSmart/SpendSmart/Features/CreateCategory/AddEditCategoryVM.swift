//
//  AddNewCategoryVM.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import Combine
import Foundation

class AddEditCategoryVM: BaseViewModel {
    @Published var categoryName: String
    @Published var selectedColor: CategoryColor
    @Published var selectedIcon: CategoryIcon
    @Published var isEdit: Bool

    var onAddUpdateCategorySuccess = PassthroughSubject<Void, Never>()
    private var id: String

    private var categoryManager = CategoryManager.shared

    init(_ category: Category?) {
        self.isEdit = category != nil
        self.id = category?.id ?? UUID().uuidString
        self.categoryName = category?.name ?? ""
        self.selectedColor = category?.getColor() ?? CategoryColor.allCases.randomElement() ?? .bronze
        self.selectedIcon = category?.getIcon() ?? CategoryIcon.allCases.randomElement() ?? .apple
    }

    func addEditCategory() {
        if isEdit {
            apiUpdateCategory()
        } else {
            addNewCategory()
        }
    }

    private func addNewCategory() {
        guard let uid = AuthServiceManager.shared.userSesstion?.uid else { return }
        showLoading(true)
        let newCategory = Category(uid: uid, name: categoryName, color: selectedColor.rawValue, image: selectedIcon.rawValue)
        categoryManager.addNewCategory(newCategory) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.showSuccessMessage(language("SS_Common_A_02"))
                self.onAddUpdateCategorySuccess.send(())
            case .failure(let failure):
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(failure.localizedDescription)
            }
        }
    }

    private func apiUpdateCategory() {
        guard let uid = AuthServiceManager.shared.userSesstion?.uid else { return }
        showLoading(true)
        let category = Category(id: id, uid: uid, name: categoryName, color: selectedColor.rawValue, image: selectedIcon.rawValue)
        categoryManager.updateCategory(category) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.showSuccessMessage(language("SS_Common_A_02"))
                self.onAddUpdateCategorySuccess.send(())
            case .failure(let failure):
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(failure.localizedDescription)
            }
        }
    }
}
