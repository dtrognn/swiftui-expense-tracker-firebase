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
                print("AAA Login error: \(failure.localizedDescription)")
            }
        }
    }

    private func savePassword() {
        // TODO: -
    }
}
