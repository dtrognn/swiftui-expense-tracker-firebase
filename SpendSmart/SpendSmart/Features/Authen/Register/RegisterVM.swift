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

    func register() {
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
                print("AAA Register failed: \(failure.localizedDescription)")
            }
        }
    }
}
