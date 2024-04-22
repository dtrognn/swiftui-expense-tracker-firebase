//
//  AddEditSavingRouter.swift
//  SpendSmart
//
//  Created by dtrognn on 22/04/2024.
//

import SwiftUI

class AddEditSavingRouter: BaseRouter<AddEditSavingRouter.Screen> {
    enum Screen: IScreen {}

    override func getInstanceScreen(_ screen: Screen) -> AnyView {}
}

struct AddEditSavingRouterView: View {
    @StateObject private var router: AddEditSavingRouter

    init(router: AddEditSavingRouter, saving: Saving? = nil) {
        self._router = StateObject(wrappedValue: router)
        AddEditSavingVM.shared.setParams(saving)
    }

    var body: some View {
        return AddEditSavingView()
            .environmentObject(router)
    }
}
