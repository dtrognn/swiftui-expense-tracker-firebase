//
//  ProfileVM.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import Foundation

class ProfileVM: BaseViewModel {
    @Published var userName: String = ""
    @Published var email: String = ""

    override func makeSubscription() {
        apiGetUserInfo()
    }

    private var authService = AuthServiceManager.shared

    private func apiGetUserInfo() {
        authService.getUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                guard let self = self else { return }
                self.userName = user?.fullname ?? ""
                self.email = user?.email ?? ""
            case .failure:
                return
            }
        }
    }

    func signOut() {
        authService.signOut { [weak self] result in
            switch result {
            case .success:
                AppDataManager.shared.updateLoginState(false)
            case .failure(let failure):
                print("AAA logout failed: \(failure.localizedDescription)")
            }
        }
    }
}
