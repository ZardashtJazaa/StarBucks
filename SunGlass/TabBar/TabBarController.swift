//
//  TwoTabViewController.swift
//  SunGlass
//
//  Created by Zardasht on 10/7/22.
//

import UIKit

class TabBarController: UIViewController {

    let tabBarView = TabBarView()
    
    var firstViewController: UINavigationController?
    var secondViewController: UINavigationController?
    var thirdViewController : UINavigationController?
    
    let containterView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
 
   
    
    private func setUp() {
        
        containterView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.homeButton.addTarget(self, action: #selector(homeButtonTrigered), for: .primaryActionTriggered)
        tabBarView.deatailButton.addTarget(self, action: #selector(detailButtonTrigedred), for: .primaryActionTriggered)
        tabBarView.searchButton.addTarget(self, action: #selector(searchButtonTrigered), for: .primaryActionTriggered)
        
    }
    
    @objc private func homeButtonTrigered() {
        
        activateViewController = firstViewController
        tabBarView.homeButton.tintColor = UIColor(named: "Colors")
        tabBarView.deatailButton.tintColor = .systemGray2
        tabBarView.searchButton.tintColor = .systemGray2
    }
    
    @objc private func detailButtonTrigedred() {
        
        activateViewController = secondViewController
        tabBarView.deatailButton.tintColor = UIColor(named: "Colors")
        tabBarView.homeButton.tintColor = .systemGray2
        tabBarView.searchButton.tintColor = .systemGray2
    }
    
    @objc private func searchButtonTrigered() {
        
        activateViewController = thirdViewController
        tabBarView.searchButton.tintColor = UIColor(named: "Colors")
        tabBarView.homeButton.tintColor = .systemGray2
        tabBarView.deatailButton.tintColor = .systemGray2
    }
    
    private func layout()  {
        
        view.addSubview(containterView)
        view.addSubview(tabBarView)
        
        
        //containterView.backgroundColor = .white
        NSLayoutConstraint.activate([
            
            containterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containterView.topAnchor.constraint(equalTo: view.topAnchor),

            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34)
        
            
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vc1 = HomeViewController()
        let vc2 = DetailViewController()
        let vc3 = SearchViewController()
        self.firstViewController = UINavigationController(rootViewController: vc1)
        self.secondViewController = UINavigationController(rootViewController: vc2)
        self.thirdViewController = UINavigationController(rootViewController: vc3)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       
        activateViewController = firstViewController
        setUp()
        layout()
    }
    
    private var activateViewController: UIViewController? {
        
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            //print("ACtivaViewcontrollerr")
            updateViewController()
        }
    }
    
    private func removeInactiveViewController(inactiveViewController:UIViewController?) {
        if let inActiveVC = inactiveViewController {
            
            inActiveVC.willMove(toParent: nil)
            inActiveVC.view.removeFromSuperview()
            inActiveVC.removeFromParent()
            
        }
    }

    private func updateViewController() {
        if let activeVC = activateViewController {
            addChild(activeVC)
            activeVC.view.frame = containterView.bounds
            containterView.addSubview(activeVC.view)
            activeVC.didMove(toParent: self)
        }
    }
    
    
}

