//
//  ProfileVM.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import Foundation
import UIKit

class ProfileVM: BaseViewModel {
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var avatarUser: String = ""
    private var currentUser: User?

    override func makeSubscription() {
        apiGetUserInfo()
    }

    private var authService = AuthServiceManager.shared
    private var storageManager = StorageManager.shared

    func uploadImage(_ image: UIImage?) {
        apiUploadImage(image)
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

    private func apiGetUserInfo() {
        authService.getUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                guard let self = self else { return }
                self.currentUser = user
                self.avatarUser = user?.avatar ?? ""
                self.userName = user?.fullname ?? ""
                self.email = user?.email ?? ""
            case .failure:
                return
            }
        }
    }

    private func apiUploadImage(_ image: UIImage?) {
        guard let image = image else { return }
        storageManager.updateImage(image) { [weak self] result in
            switch result {
            case .success(let path):
                guard let self = self else { return }
                self.apiUpdateUser(path)
            case .failure(let failure):
                guard let self = self else { return }
                self.showErrorMessage(failure.localizedDescription)
            }
        }
    }

    private func apiUpdateUser(_ path: String) {
        guard let currentUser = currentUser else { return }
        let user = User(uid: currentUser.uid,
                        email: currentUser.email,
                        fullname: currentUser.fullname,
                        createdAt: currentUser.createdAt,
                        avatar: path,
                        phoneNumber: currentUser.phoneNumber,
                        address: currentUser.address)

        authService.updateUserInfo(user) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.avatarUser = path
            case .failure:
                guard let self = self else { return }
                showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
