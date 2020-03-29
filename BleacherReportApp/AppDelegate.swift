//
//  AppDelegate.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = PhotoSearchViewModel()
        
        if let window = window {
            //DI
            let photoSearchController = PhotoSearchController.create(with: viewModel)
            window.rootViewController = UINavigationController(rootViewController: photoSearchController)
            window.makeKeyAndVisible()
        }
        customizeNavigationBar()
        
        return true
    }
    
    private func customizeNavigationBar() {
        guard let navController = window?.rootViewController as? UINavigationController else { return }
        
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.barStyle = .black
        navController.navigationBar.tintColor = .white      
        navController.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
    }

   


}

