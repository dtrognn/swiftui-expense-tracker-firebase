//
//  SplashScreenView.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        Text("SplashScreenView")
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    router.push(to: .mainTab)
                }
            }
    }
}

#Preview {
    SplashScreenView()
}
