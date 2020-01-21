//
//  AppCoordinator.swift
//  SoundRecording
//
//  Created by Денис Магильницкий on 20/01/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit

final class AppCoordinator {
    static let shared = AppCoordinator()
    private init() {}
    
    let rootViewController = RecordViewController()
    
    func root(_ window: inout UIWindow?) {
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
    }
}
