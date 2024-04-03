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
        AuthServiceManager.shared.signUp(email: email, password: password, fullname: fullname) { [weak self] result in
            switch result {
            case .success(let success):
                AppDataManager.shared.updateLoginState(true)
            case .failure(let failure):
                print("AAA Register failed: \(failure.localizedDescription)")
            }
        }
    }
}
