//
//  SearchView.swift
//  SunGlass
//
//  Created by Zardasht on 10/5/22.
//

import UIKit

class SearchView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        //layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Init Coder has Not been Implemented!")
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 40)
        
    }
    
    
}


extension SearchView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "LoginForm")
        layer.cornerRadius = 20
       
    }
    
    func layout() {
        
    }
    
}
