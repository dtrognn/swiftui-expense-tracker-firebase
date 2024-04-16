//
//  ChangeLanguageVM.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import Foundation
import SwiftUI

class ChangeLanguageVM: BaseViewModel {
    @Published var languageList = [LanguageItemData]()

    private let languageManager = LanguageManager.shared

    override func makeSubscription() {
        languageManager.onChangeLanguage.sink { [weak self] _ in
            self?.initData()
        }.store(in: &cancellableSet)
    }

    override func initData() {
        let languageCodeCurrent = languageManager.currentLanguage
        languageList = [
            LanguageItemData(id: UUID().uuidString,
                             leftImage: Image("ic_language_default"),
                             title: language("Language_A_02"),
                             value: .system,
                             isSelected: languageCodeCurrent == .system,
                             onSelect: { code in
                                 LanguageManager.shared.setLanguage(code)
                             }),
            LanguageItemData(id: UUID().uuidString,
                             leftImage: Image("ic_language_vi"),
                             title: language("Language_A_03"),
                             value: .vi,
                             isSelected: languageCodeCurrent == .vi,
                             onSelect: { code in
                                 self.languageManager.setLanguage(code)
                             }),
            LanguageItemData(id: UUID().uuidString,
                             leftImage: Image("ic_language_en"),
                             title: language("Language_A_04"),
                             value: .en,
                             isSelected: languageCodeCurrent == .en,
                             onSelect: { code in
                                 self.languageManager.setLanguage(code)
                             })
        ]
    }
}
