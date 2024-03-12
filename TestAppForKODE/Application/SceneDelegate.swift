//
//  SceneDelegate.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = EmployeeProfileVIewController()
        window?.makeKeyAndVisible()
        
        let a = BuilderForGetEmployee()
        a.get()
    }

}

