//
//  AppDelegate.swift
//  ToDoApp_exam
//
//  Created by Chingiz Jumanov on 26/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = MainVC(nibName: "MainVC", bundle: nil)
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }


}

