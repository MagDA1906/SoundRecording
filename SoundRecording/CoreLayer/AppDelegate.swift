//
//  AppDelegate.swift
//  SoundRecording
//
//  Created by Денис Магильницкий on 20/01/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AppCoordinator.shared.root(&window)
        
        return true
    }
}

