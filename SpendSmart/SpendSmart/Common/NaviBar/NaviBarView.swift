//
//  NaviBarView.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import Combine
import SwiftUI

public struct NaviBarView: View {
    @EnvironmentObject private var navigationStack: SSNavigationPath
    @ObservedObject public var screenConfiguration: ScreenConfiguration

    public var body: some View {
        VStack(spacing: AppStyle.layout.zero) {
            HStack {
                if screenConfiguration.showBackButton {
                    backButton
                }
                Spacer()
                titleSection
                Spacer()

                if screenConfiguration.showPopToRootButton {
                    if navigationStack.depth >= screenConfiguration.depthScreen {
                        homeButton
                    } else {
                        homeButton.opacity(0)
                    }
                }
            }.padding(AppStyle.layout.standardSpace)
                .navigationBarHidden(true)
                .background(
                    AppStyle.theme.naviBackgroundColor
                        .ignoresSafeArea(edges: .top)
                )
            StraightLine()
        }
    }
}

extension NaviBarView {
    private var backButton: some View {
        return Button {
            if screenConfiguration.onBackAction != nil {
                screenConfiguration.onBackAction?()
            } else {
                self.navigationStack.pop()
            }
        } label: {
            Image("ic_back_white")
                .resizable()
                .applyTheme(.black)
                .frame(width: 22, height: 22)
        }
    }

    var titleSection: some View {
        return VStack {
            Text(LocalizedStringKey(screenConfiguration.title))
                .foregroundColor(AppStyle.theme.naviTextColor)
                .font(AppStyle.font.semibold16)
                .lineLimit(1)
        }
    }

    var homeButton: some View {
        return Button {
            navigationStack.pop(to: .root)
        } label: { }
    }
}

struct NaviBarView_Previews: PreviewProvider {
    static var previews: some View {
        NaviBarView(screenConfiguration: ScreenConfiguration(title: "Test"))
    }
}
