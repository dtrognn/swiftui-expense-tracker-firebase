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

    init(_ category: Category?) {
        self.isEdit = category != nil
        self.categoryName = category?.name ?? ""
        self.selectedColor = category?.getColor() ?? CategoryColor.allCases.randomElement() ?? .bronze
        self.selectedIcon = category?.getIcon() ?? CategoryIcon.allCases.randomElement() ?? .apple
    }

    func addEditCategory() {
        if isEdit {
        } else {
            addNewCategory()
        }
    }

    private func addNewCategory() {
        guard let uid = AuthServiceManager.shared.userSesstion?.uid else { return }
        showLoading(true)
        let newCategory = Category(uid: uid, name: categoryName, color: selectedColor.rawValue, image: selectedIcon.rawValue)
        try? FIRCategoryCollection.document(newCategory.id).setData(newCategory.asDictionary()) { [weak self] error in
            if let error = error {
                self?.showLoading(false)
                self?.showErrorMessage(error.localizedDescription)
            } else {
                self?.showLoading(false)
                self?.showSuccessMessage(language("SS_Common_A_02"))
                self?.onAddUpdateCategorySuccess.send(())
            }
        }
    }
}
