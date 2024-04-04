//
//  ProfileVM.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import Foundation

class ProfileVM: BaseViewModel {
    func signOut() {
        AuthServiceManager.shared.signOut { [weak self] result in
            switch result {
            case .success(let success):
                AppDataManager.shared.updateLoginState(false)
            case .failure(let failure):
                print("AAA logout failed: \(failure.localizedDescription)")
            }
        }
    }
}
