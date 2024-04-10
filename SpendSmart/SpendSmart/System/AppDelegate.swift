//
//  AppDelegate.swift
//  SpendSmart
//
//  Created by dtrognn on 01/04/2024.
//

import FirebaseCore
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    static var shared: AppDelegate!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        FirebaseApp.configure()
        AppDataManager.shared.loadData()
        AppDataManager.shared.loadConfig()

        return true
    }
}
