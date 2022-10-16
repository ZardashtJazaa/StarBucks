//
//  PopularCollectionViewCell.swift
//  SunGlass
//
//  Created by Zardasht on 10/7/22.
//

import UIKit
import SDWebImage
class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: PopularCollectionViewCell.self)
    
    private let popularView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
    
    private let popularImage: UIImageView = {
       
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 4
        return image
        
    }()
    
    private let popularTitle: UILabel = {
       
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let popularDescription: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = label.font.withSize(13)
        
        return label
    }()
    
    private let popularPrice: UILabel = {
       
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
        
    }()
    
    private let popularBag: UIImageView =  {
       
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "Colors")
        image.image = UIImage(systemName: "takeoutbag.and.cup.and.straw.fill")
        return image
        
    }()
    
     func configurations(image:String,title:String,description:String,price:String ) {
         DispatchQueue.main.async {
             guard let url = URL(string: image) else { return }
             self.popularImage.sd_setImage(with: url)
         }
        popularTitle.text = title
//        let formater = NumberFormatter()
//        let nsPrice = price as NSNumber
//        formater.numberStyle = .currency
        popularPrice.text = "$\(price)"
        popularDescription.text = description
         
        
    }
    
    //MARK: - Layout
    private func layout() {
            
        popularView.backgroundColor = UIColor(named: "LoginForm")
        popularView.translatesAutoresizingMaskIntoConstraints = false
        popularView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            //PopularView
            popularView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            popularView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            popularView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            popularView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
           //PopularImage
            popularImage.leadingAnchor.constraint(equalTo: popularView.leadingAnchor, constant: 10),
            popularImage.topAnchor.constraint(equalTo: popularView.topAnchor, constant: 10),
            popularImage.bottomAnchor.constraint(equalTo: popularView.bottomAnchor, constant: -10),
            popularImage.widthAnchor.constraint(equalToConstant: 150),
            
           
            //PopularTtile
            popularTitle.leadingAnchor.constraint(equalTo: popularImage.trailingAnchor, constant: 10),
            popularTitle.topAnchor.constraint(equalTo: popularView.topAnchor,constant: 10),
            popularTitle.trailingAnchor.constraint(equalTo: popularView.trailingAnchor, constant: -10),
            //PopularDescriptions
            popularDescription.leadingAnchor.constraint(equalTo: popularImage.trailingAnchor, constant: 10),
            popularDescription.topAnchor.constraint(equalTo: popularTitle.bottomAnchor, constant: 0),
            popularDescription.trailingAnchor.constraint(equalTo: popularView.trailingAnchor, constant: -10),
            //popularPrice
            popularPrice.leadingAnchor.constraint(equalTo: popularImage.trailingAnchor, constant: 10),
            popularPrice.topAnchor.constraint(equalTo: popularDescription.bottomAnchor, constant: 5),
            popularPrice.bottomAnchor.constraint(equalTo: popularView.bottomAnchor, constant: -10),
            popularPrice.widthAnchor.constraint(equalToConstant: 70),
            //PopularBag
            popularBag.trailingAnchor.constraint(equalTo: popularView.trailingAnchor, constant: -10),
            popularBag.bottomAnchor.constraint(equalTo: popularView.bottomAnchor, constant: -10),
            popularBag.widthAnchor.constraint(equalToConstant: 30),
            popularBag.heightAnchor.constraint(equalToConstant: 30),
            
            
            
        ])
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(popularView)
        popularView.addSubview(popularImage)
        popularView.addSubview(popularTitle)
        popularView.addSubview(popularDescription)
        popularView.addSubview(popularPrice)
        popularView.addSubview(popularBag)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    
    
    
    
}
