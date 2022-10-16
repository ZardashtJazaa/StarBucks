//
//  TrendingNowView.swift
//  SunGlass
//
//  Created by Zardasht on 10/6/22.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingNowView: UIView {
    
   
      let trendingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        lazy var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    
    }()


    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        trendingCollection.delegate = self
        //trendingCollection.dataSource = self
       
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Init Coder has Not been Implemented!")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 370, height: 300)

    }
    
    
}

extension TrendingNowView:   UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 2 , height: collectionView.frame.height )
    }
    
    
}

extension TrendingNowView {
    
    func style() {
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
        
    }
    
    func layout() {
        
        addSubview(trendingCollection)
        
        NSLayoutConstraint.activate([
            
            trendingCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            trendingCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            trendingCollection.topAnchor.constraint(equalTo: topAnchor),
            trendingCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
    }
    
}
