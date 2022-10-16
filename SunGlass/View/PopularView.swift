//
//  PopularView.swift
//  SunGlass
//
//  Created by Zardasht on 10/7/22.
//

import UIKit

class PopularView: UIView {
    
     let popularCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        lazy var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        popularCollection.delegate = self
        //popularCollection.dataSource = self
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Init Coder has Not been Implemented!")
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 370, height: 150)
        
    }
    
    
}

extension PopularView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
    
    func layout() {
        
        addSubview(popularCollection)
        
        NSLayoutConstraint.activate([
            
            popularCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            popularCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularCollection.topAnchor.constraint(equalTo: topAnchor),
            popularCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
    }
    
}

extension PopularView:  UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
//
//        cell.configurations(image: "coffe1", title: "Mocha", description: "Expretly steamed choclate milk blended with espresso for a", price: 12)
//        return cell
//
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width  , height: collectionView.frame.height )
    }
    
    
}


