//
//  LogoAppView.swift
//  SpendSmart
//
//  Created by dtrognn on 03/04/2024.
//

import SwiftUI

struct LogoAppView: View {
    private let logoWidth: CGFloat = 200
    var body: some View {
        VStack {
            Image("ic_logo_app")
                .resizable()
                .scaledToFit()
                .frame(width: logoWidth, height: logoWidth)
        }
    }
}
