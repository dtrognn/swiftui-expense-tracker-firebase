//
//  LoginVM.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import Combine
import Foundation

class LoginVM: BaseViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isEnableButton: Bool = false
    @Published var isRememberPassword: Bool = false

    private let KEY_ACCOUNT_SAVED = "KEY_ACCOUNT_SAVED"
    private let KEY_PASSWORD_SAVED = "KEY_PASSWORD_SAVED"
    private let KEY_REMEMBER_PASS = "KEY_REMEMBER_PASS"

    override init() {
        super.init()
        loadDataFromLocal()
    }

    override func makeSubscription() {
        Publishers.CombineLatest($email, $password).map { [weak self] email, password in
            !email.isEmpty && self?.isValidPassword(password) ?? false
        }.assign(to: &$isEnableButton)
    }

    func signIn() {
        showLoading(true)
        AuthServiceManager.shared.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.savePassword()
                AppDataManager.shared.updateLoginState(true)
            case .failure(let failure):
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(failure.localizedDescription)
            }
        }
    }

    private func savePassword() {
        StoreLocal.shared.setValue(key: KEY_ACCOUNT_SAVED, value: email)

        if isRememberPassword {
            StoreLocal.shared.setValue(key: KEY_PASSWORD_SAVED, value: password)
        } else {
            StoreLocal.shared.setValue(key: KEY_PASSWORD_SAVED, value: "")
        }
    }

    private func loadDataFromLocal() {
        email = StoreLocal.shared.getStringValue(KEY_ACCOUNT_SAVED)
        password = StoreLocal.shared.getStringValue(KEY_PASSWORD_SAVED)
        isRememberPassword = !password.isEmpty
    }

    private func isValidPassword(_ password: String) -> Bool {
        return UtilsHelper.isValidPassword(password)
    }
}
