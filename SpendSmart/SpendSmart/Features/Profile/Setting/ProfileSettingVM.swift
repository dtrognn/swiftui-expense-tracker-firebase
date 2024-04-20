//
//  ProfileSettingVM.swift
//  SpendSmart
//
//  Created by dtrognn on 16/04/2024.
//

import Foundation

class ProfileSettingVM: BaseViewModel {
    @Published var isDarkMode: Bool = false

    override func initData() {
        isDarkMode = StoreLocal.shared.getBoolValue(.KEY_IS_DARK_MODE)
    }

    func handleChangeDarkMode(_ isDarkMode: Bool) {
        AppStyle.isDarkMode = isDarkMode
        StoreLocal.shared.setValue(key: .KEY_IS_DARK_MODE, value: isDarkMode)
    }
}

extension String {
    static var KEY_IS_DARK_MODE = "KEY_IS_DARK_MODE"
}
