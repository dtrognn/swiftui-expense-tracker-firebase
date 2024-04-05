//
//  AddNewCategoryVM.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import Foundation

class AddEditCategoryVM: BaseViewModel {
    @Published var categoryName: String
    @Published var selectedColor: CategoryColor
    @Published var selectedIcon: CategoryIcon
    @Published var isEdit: Bool

    init(_ category: Category?) {
        self.isEdit = category != nil
        self.categoryName = category?.name ?? ""
        self.selectedColor = category?.getColor() ?? CategoryColor.allCases.randomElement() ?? .bronze
        self.selectedIcon = category?.getIcon() ?? CategoryIcon.allCases.randomElement() ?? .apple
    }
}
