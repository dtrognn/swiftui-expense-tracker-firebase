//
//  ProfileSettingVM.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import Foundation

class ProfileSettingVM: BaseViewModel {
    @Published var isDarkMode: Bool = false

    func handleChangeDarkMode(_ isDarkMode: Bool) {
        AppStyle.isDarkMode = isDarkMode
    }
}
