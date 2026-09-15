//
//  UIKitApp.swift
//  UIKit
//
//  Created by 이시우 on 9/10/26.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: StudentListViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
