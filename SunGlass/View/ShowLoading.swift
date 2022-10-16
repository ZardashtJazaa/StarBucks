//
//  ShowLoading.swift
//  SunGlass
//
//  Created by Zardasht on 10/10/22.
//

import UIKit

fileprivate var activeView: UIView?

extension UIViewController {
    
    func showSpinner() {
        
        activeView = UIView(frame: self.view.bounds)
        activeView?.backgroundColor = .init(white: 0, alpha: 0.5)
        
        let active = UIActivityIndicatorView(style: .large)
        active.center = activeView!.center
        active.startAnimating()
        activeView?.addSubview(active)
        self.view.addSubview(activeView!)
        
    }
    
    func removeSpinner() {
        activeView?.removeFromSuperview()
        activeView = nil
    }
    
}
