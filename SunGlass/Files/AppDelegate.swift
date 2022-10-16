//
//  AppDelegate.swift
//  SunGlass
//
//  Created by Zardasht on 10/2/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
//        let vc1 = HomeViewController()
//        let vc2 = DetailViewController()
//        let vc3 = SearchViewController()
        
       // vc1.view.backgroundColor = .yellow
       // vc2.view.backgroundColor = .systemPink
//        let towTab = TabBarController()
//        towTab.firstViewController = UINavigationController(rootViewController: vc1)
//        towTab.secondViewController = UINavigationController(rootViewController: vc2)
//        towTab.thirdViewController = UINavigationController(rootViewController: vc3)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        
        
        
        ///////
        
        
//        let controller = HomeViewController()
//        let navController = UINavigationController(rootViewController: controller)
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .black
//
        
        return true
    }



}

