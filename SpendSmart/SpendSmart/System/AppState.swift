//
//  AppState.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import Foundation
import FirebaseAuth

struct AppState {
    var loginState: LoginState = .init()
}

class LoginState: ObservableObject {
    @Published var loggedIn: Bool = true

    init() {
        loggedIn = Auth.auth().currentUser != nil
    }
}
