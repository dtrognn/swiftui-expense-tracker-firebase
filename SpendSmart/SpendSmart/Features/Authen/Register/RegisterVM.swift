//
//  RegisterVM.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import Combine
import Foundation

class RegisterVM: BaseViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullname: String = ""
    @Published var isEnableButton: Bool = false
    @Published var showEmailError: Bool = false
    @Published var showPasswordError: Bool = false

    override func makeSubscription() {
        Publishers.CombineLatest3($fullname, $email, $password).map { fullname, email, password in
            !fullname.isEmpty && !email.isEmpty && self.isValidPassword(password)
        }.assign(to: &$isEnableButton)
    }

    func register() {
        if !checkValidate() { return }

        showLoading(true)
        AuthServiceManager.shared.signUp(email: email, password: password, fullname: fullname) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                AppDataManager.shared.updateLoginState(true)
            case .failure(let failure):
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(failure.localizedDescription)
            }
        }
    }

    private func checkValidate() -> Bool {
        if !UtilsHelper.checkValidate(email, validateType: .email) {
            showEmailError = true
            return false
        }

        if !UtilsHelper.isValidRegexPassword(password) {
            showEmailError = false
            showPasswordError = true
            return false
        }

        showEmailError = false
        showPasswordError = false

        return true
    }

    private func isValidPassword(_ password: String) -> Bool {
        return UtilsHelper.isValidPassword(password)
    }
}
