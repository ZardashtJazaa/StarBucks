//
//  MainTabBarViewController.swift
//  SunGlass
//
//  Created by Zardasht on 10/4/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: DetailViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        //let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        // vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        
        vc1.title = "Home"
        vc2.title = "Detail View"
        vc3.title = "Popular"
        //  vc4.title = "Downloads"
        
//        tabBar.tintColor = UIColor(named: "Colors")
//        tabBar.backgroundColor = .white
//        setViewControllers([vc1,vc2,vc3], animated: true)
        
    }
    
    
    
    
}
