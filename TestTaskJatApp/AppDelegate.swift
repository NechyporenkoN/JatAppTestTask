//
//  AppDelegate.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var navigationController = UINavigationController()
	var loginTableViewController: LoginTableViewController?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		setRootViewController()
		return true
	}
	
	func setRootViewController() {
		
		if let token = UserDefaults.standard.string(forKey: "Token") {
			let resultsTableViewController = ResultsTableViewController(token: token)
			navigationController = UINavigationController(rootViewController: resultsTableViewController)
			window?.rootViewController = navigationController
		} else {
			loginTableViewController = LoginTableViewController()
			navigationController = UINavigationController(rootViewController: loginTableViewController!)
			window?.rootViewController = navigationController
		}
	}
}

