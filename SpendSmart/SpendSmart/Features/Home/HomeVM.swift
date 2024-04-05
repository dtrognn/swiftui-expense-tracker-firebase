//
//  HomeVM.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import FirebaseAuth
import Foundation

class HomeVM: BaseViewModel {
    @Published var username: String = ""

    private let authService = AuthServiceManager.shared

    func loadDataUser() {
        apiGetUserInfo()
    }

    private func apiGetUserInfo() {
        authService.getUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                guard let user = user else { return }
                self?.username = user.fullname
            case .failure(let failure):
                print("AAA get user failed: \(failure.localizedDescription)")
            }
        }
    }
}
