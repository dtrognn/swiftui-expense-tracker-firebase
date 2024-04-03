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

    func signIn() {
        showLoading(true)
        AuthServiceManager.shared.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                self.showLoading(false)
                AppDataManager.shared.updateLoginState(true)
            case .failure(let failure):
                guard let self = self else { return }
                self.showLoading(false)
                print("AAA Login error: \(failure.localizedDescription)")
            }
        }
    }
}
