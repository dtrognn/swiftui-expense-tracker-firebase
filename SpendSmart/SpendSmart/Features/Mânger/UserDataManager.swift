//
//  UserDataManager.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import Foundation

class UserDataManager: BaseViewModel {
    static let shared = UserDataManager()

    private let storeLocal = StoreLocal.shared

    func saveUserInfo(_ user: User) {
        storeLocal.setValue(key: .KEY_USER_NAME, value: user.fullname)
        storeLocal.setValue(key: .KEY_USER_EMAIL, value: user.email)
        storeLocal.setValue(key: .KEY_USER_IMAGE_URL, value: user.avatar ?? "")
    }

    func getUserName() -> String {
        return storeLocal.getStringValue(.KEY_USER_NAME)
    }

    func getUserEmail() -> String {
        return storeLocal.getStringValue(.KEY_USER_EMAIL)
    }

    func getUserAvatarURL() -> String {
        return storeLocal.getStringValue(.KEY_USER_IMAGE_URL)
    }
}

extension String {
    static var KEY_USER_NAME = "KEY_USER_NAME"
    static var KEY_USER_IMAGE_URL = "KEY_USER_IMAGE_URL"
    static var KEY_USER_EMAIL = "KEY_USER_EMAIL"
}
