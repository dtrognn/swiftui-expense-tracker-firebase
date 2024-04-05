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

    init(_ category: Category?) {
        self.categoryName = category?.name ?? ""
        self.selectedColor = category?.getColor() ?? CategoryColor.allCases.randomElement() ?? .bronze
    }
}
