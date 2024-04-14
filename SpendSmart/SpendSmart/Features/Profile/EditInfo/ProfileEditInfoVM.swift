//
//  ProfileEditInfoVM.swift
//  SpendSmart
//
//  Created by dtrognn on 14/04/2024.
//

import Combine
import Foundation

class ProfileEditInfoVM: BaseViewModel {
    @Published var email: String
    @Published var fullname: String
    @Published var phoneNumber: String
    @Published var address: String

    var onUpdateSuccess = PassthroughSubject<Void, Never>()

    private var user: User

    init(_ user: User) {
        self.user = user
        self.email = user.email
        self.fullname = user.fullname
        self.phoneNumber = user.phoneNumber ?? ""
        self.address = user.address ?? ""
    }

    func updateUserInfo() {
        apiUpdateUserInfo()
    }

    private func apiUpdateUserInfo() {
        let user = User(uid: self.user.uid,
                        email: self.user.email,
                        fullname: fullname,
                        createdAt: self.user.createdAt,
                        avatar: self.user.avatar,
                        phoneNumber: phoneNumber,
                        address: address)
        showLoading(true)
        AuthServiceManager.shared.updateUserInfo(user) { [weak self] result in
            switch result {
            case .success:
                guard let self = self else { return }
                self.showLoading(false)
                self.showSuccessMessage(language("SS_Common_A_02"))
                self.onUpdateSuccess.send(())
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
