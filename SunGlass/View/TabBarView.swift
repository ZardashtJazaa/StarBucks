//
//  TabBarView.swift
//  SunGlass
//
//  Created by Zardasht on 10/5/22.
//

import UIKit


class TabBarView: UIView {
    
    let stackView = UIStackView()
    let homeButton = UIButton()
    let deatailButton = UIButton()
    let searchButton = UIButton()
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Init Coder has Not been Implemented!")
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 240, height: 65)
        
    }
    
    
}


extension TabBarView {
    
    func setUp() {
        
        //deatailButton.addTarget(self, action: #selector(detail), for: .primaryActionTriggered)
        
      
    }
    
    
    
    func style() {
        backgroundColor = UIColor(named: "LoginForm")
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        deatailButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        //StackView
        stackView.axis = .horizontal
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillEqually
        
        //HomeButton
        homeButton.setImage(UIImage(systemName: "house.circle.fill"), for: .normal)
        homeButton.tintColor = UIColor(named: "Colors")
        homeButton.imageView?.contentMode = .scaleAspectFit
        homeButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
 
        //HomeButton
        deatailButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        deatailButton.tintColor = .systemGray2
        deatailButton.imageView?.contentMode = .scaleAspectFit
        deatailButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
    
        //HomeButton
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .systemGray2
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        
    
        
    }
    
    func layout() {
        
        addSubview(stackView)
        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(deatailButton)
        stackView.addArrangedSubview(searchButton)
        NSLayoutConstraint.activate([
            
            //stackView
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
          
        ])
        
    }
    
}
