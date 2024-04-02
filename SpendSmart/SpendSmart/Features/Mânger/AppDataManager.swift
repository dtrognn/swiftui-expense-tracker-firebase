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

    init() {
        self.appState = AppState()
    }

    var isLogout: Bool {
        return !appState.loginState.loggedIn
    }

    func updateLoginState(_ loggedIn: Bool) {
        appState.loginState.loggedIn = loggedIn
    }
}
