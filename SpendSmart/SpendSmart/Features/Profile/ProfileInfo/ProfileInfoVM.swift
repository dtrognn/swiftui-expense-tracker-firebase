//
//  ProfileInfoVM.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import Foundation

class ProfileInfoVM: BaseViewModel {
    private let authService = AuthServiceManager.shared

    @Published var avatarUrl: String = ""
    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var dateCreated: String = ""
    @Published var phoneNumber: String = ""
    @Published var address: String = ""

    var user = User()

    override func makeSubscription() {
        loadData()
    }

    func loadData() {
        apiGetUserInfo()
    }

    private func apiGetUserInfo() {
        showLoading(true)
        authService.getUserInfo { [weak self] result in
            switch result {
            case .success(let user):
                guard let self = self, let user = user else { return }
                self.showLoading(false)
                self.user = user
                self.avatarUrl = user.avatar ?? ""
                self.fullname = user.fullname
                self.email = user.email
                self.phoneNumber = user.phoneNumber ?? ""
                self.address = user.address ?? ""

                let date = Date(timeIntervalSince1970: user.createdAt)
                self.dateCreated = String(format: "%02d/%02d/%02d", date.day, date.month, date.year)
            case .failure:
                guard let self = self else { return }
                self.showLoading(false)
                self.showErrorMessage(language("SS_Common_A_06"))
            }
        }
    }
}
