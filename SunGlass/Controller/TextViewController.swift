//
//  TextViewController.swift
//  SunGlass
//
//  Created by Zardasht on 10/11/22.
//

import UIKit

class TextViewController: UIViewController {
    
    let tableView: UITableView =  {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(searchTableViewCell.self, forCellReuseIdentifier: searchTableViewCell.identifier)
        table.backgroundColor = .clear
        table.layer.cornerRadius = 10
        table.allowsSelection = false
        table.isScrollEnabled = true
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "HomeColorBackground")
        tableView.delegate = self
        layout()
        
    }
    
    private func style() {
        
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
}

extension TextViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
