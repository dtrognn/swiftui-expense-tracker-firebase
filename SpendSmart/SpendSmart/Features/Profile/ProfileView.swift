//
//  ProfileView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileVM()

    var body: some View {
        logout
    }
}

private extension ProfileView {
    var logout: some View {
        return Button {
            vm.signOut()
        } label: {
            Text("Register")
        }.buttonStyle(.standard())
    }
}
