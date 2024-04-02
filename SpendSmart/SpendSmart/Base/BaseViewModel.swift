//
//  BaseVM.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import Combine
import Foundation

open class BaseViewModel: ObservableObject {
    var cancellableSet: Set<AnyCancellable> = []

    init() {
        loadData()
        makeSubscription()
        subcribe()
    }

    open func loadData() {}

    open func makeSubscription() {}

    open func subcribe() {}

    func showLoading(_ show: Bool) {
        if show {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
}
