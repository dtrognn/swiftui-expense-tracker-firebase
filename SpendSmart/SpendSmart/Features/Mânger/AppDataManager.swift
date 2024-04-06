//
//  AppDataManager.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import Foundation

class AppDataManager: ObservableObject {
    static let shared = AppDataManager()

    let appState: AppState
    let appLanguage: AppLanguage

    init() {
        AuthServiceManager.shared.loadUser()
        self.appState = AppState()
        self.appLanguage = AppLanguage()
    }

    func loadData() {
        CategoryManager.shared.getCategories()
    }

    func loadConfig() {
        configureAlertMessage()
    }

    var isLogout: Bool {
        return !appState.loginState.loggedIn
    }

    func updateLoginState(_ loggedIn: Bool) {
        appState.loginState.loggedIn = loggedIn
    }

    private func configureAlertMessage() {
        let defaultConfig = DefaultAlertMessageConfiguration()
        defaultConfig.configure()
        AlertMessageConfiguration.shared.addAlertMessage(.defaultAlert, alertMessage: defaultConfig)

        let bannerConfig = BannerAlertMessageConfiguration()
        bannerConfig.configure()
        AlertMessageConfiguration.shared.addAlertMessage(.banner, alertMessage: bannerConfig)
    }
}
