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
        self.categories = categoryManager.categories
    }
}
