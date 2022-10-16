//
//  TrendingCollectionViewCell.swift
//  SunGlass
//
//  Created by Zardasht on 10/6/22.
//

import UIKit
import SDWebImage

class TrendingCollectionViewCell: UICollectionViewCell {
    
    
    
    static let identifier = String(describing: TrendingCollectionViewCell.self)
    let trendingCellView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 300))
    
    private let imageProduct: UIImageView = {
       
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 4
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    
    private let titleProduct: UILabel = {
       
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionProduct: UILabel = {
       
        let descriptLabel = UILabel()
        descriptLabel.font = descriptLabel.font.withSize(13)
        descriptLabel.textColor = .systemGray
        descriptLabel.numberOfLines = 0
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptLabel
        
    }()
    
    private let priceProduct: UILabel = {
       
        let price = UILabel()
        price.textColor = .black
        price.numberOfLines = 1
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = UIFont.boldSystemFont(ofSize: 14)
        return price
    }()
    
    private let cartBag: UIImageView = {
       
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "Colors")
        return image
    }()
   
    
    
    func configureImageCell(imageName: String,title:String,descriptions:String,price:String) {

        DispatchQueue.main.async { 
            guard let url = URL(string: imageName) else { return }
            self.imageProduct.sd_setImage(with: url)
        }
        titleProduct.text = title
//        let nsPrice = price as NSNumber
//        let formater = NumberFormatter()
//        formater.numberStyle = .currency
        priceProduct.text = "$\(price)"
        descriptionProduct.text = descriptions
        cartBag.image = UIImage(systemName: "takeoutbag.and.cup.and.straw.fill")
    }

    private func layout() {
        
        trendingCellView.translatesAutoresizingMaskIntoConstraints = false
        trendingCellView.layer.cornerRadius = 10
        trendingCellView.backgroundColor = UIColor(named: "LoginForm")
        
        NSLayoutConstraint.activate([
        
            //TrendingCellView
            trendingCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            trendingCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            trendingCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            trendingCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            //ImageProduct
            imageProduct.leadingAnchor.constraint(equalTo: trendingCellView.leadingAnchor, constant: 10),
            imageProduct.trailingAnchor.constraint(equalTo: trendingCellView.trailingAnchor, constant: -10),
            imageProduct.topAnchor.constraint(equalTo: trendingCellView.topAnchor, constant: 10),
            imageProduct.heightAnchor.constraint(equalToConstant: 120),
            //TitleProduct
            titleProduct.leadingAnchor.constraint(equalTo: trendingCellView.leadingAnchor, constant: 10),
            titleProduct.topAnchor.constraint(equalTo: imageProduct.bottomAnchor,constant: 10),
            titleProduct.trailingAnchor.constraint(equalTo: trendingCellView.trailingAnchor, constant: -10),
            //DescriptionProduct
            descriptionProduct.leadingAnchor.constraint(equalTo: trendingCellView.leadingAnchor, constant: 10),
            descriptionProduct.trailingAnchor.constraint(equalTo: trendingCellView.trailingAnchor, constant: -10),
            descriptionProduct.topAnchor.constraint(equalTo: titleProduct.bottomAnchor, constant: 10),
            //PirceProduct
            priceProduct.leadingAnchor.constraint(equalTo: trendingCellView.leadingAnchor, constant: 10),
            priceProduct.trailingAnchor.constraint(equalTo: trendingCellView.trailingAnchor, constant: -10),
            priceProduct.bottomAnchor.constraint(equalTo: trendingCellView.bottomAnchor, constant: -10),
            //CartBag
            cartBag.widthAnchor.constraint(equalToConstant: 30),
            cartBag.heightAnchor.constraint(equalToConstant: 30),
            cartBag.trailingAnchor.constraint(equalTo: trendingCellView.trailingAnchor, constant: -10),
            cartBag.bottomAnchor.constraint(equalTo: trendingCellView.bottomAnchor, constant: -10),
        ])
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        layout()
        layer.cornerRadius = 15

        //imageProduct.image = UIImage(named: "logo")
        contentView.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(trendingCellView)
        trendingCellView.addSubview(imageProduct)
        trendingCellView.addSubview(titleProduct)
        trendingCellView.addSubview(descriptionProduct)
        trendingCellView.addSubview(priceProduct)
        trendingCellView.addSubview(cartBag)
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    
}
