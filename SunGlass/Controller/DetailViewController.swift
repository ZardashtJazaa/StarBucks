//
//  DetailViewController.swift
//  SunGlass
//
//  Created by Zardasht on 10/4/22.
//

import UIKit
import RxSwift
import RxCocoa
class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DetailView"
        view.backgroundColor = .gray
        print("Resources Count \(RxSwift.Resources.total)")
    }

}
