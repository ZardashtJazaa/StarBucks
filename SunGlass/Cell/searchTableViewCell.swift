//
//  searchTableViewCell.swift
//  SunGlass
//
//  Created by Zardasht on 10/11/22.
//

import UIKit

class searchTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: searchTableViewCell.self)
    let searchView = UIView(frame: CGRect(x: 0, y: 0, width: UIView.noIntrinsicMetric, height: 150))
 
    private let searchImage: UIImageView =  {
       
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 4
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    
    private let titleSearch: UILabel = {
       
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let descriptionSearch: UILabel = {
       
        let descriptLabel = UILabel()
        descriptLabel.font = descriptLabel.font.withSize(13)
        descriptLabel.textColor = .systemGray
        descriptLabel.numberOfLines = 0
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptLabel
        
    }()
    
    private let priceSearch: UILabel = {
       
        let price = UILabel()
        price.textColor = .black
        price.numberOfLines = 1
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = UIFont.boldSystemFont(ofSize: 14)
        return price
    }()
    
    
    private let cartBagSearch: UIImageView = {
       
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(named: "Colors")
        return image
    }()
   
    func configureSearchCell(imageName: String,title:String,descriptions:String,price:String) {

        DispatchQueue.main.async {
            guard let url = URL(string: imageName) else { return }
            self.searchImage.sd_setImage(with: url)
        }
        titleSearch.text = title
        priceSearch.text = "$\(price)"
        descriptionSearch.text = descriptions
        cartBagSearch.image = UIImage(systemName: "takeoutbag.and.cup.and.straw.fill")
    }
    
    
    private func constraints() {
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            //SearchView
            searchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            searchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            searchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            searchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            //SearchImage
            searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10),
            searchImage.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10),
            searchImage.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -10),
            //searchImage.heightAnchor.constraint(equalToConstant: 120),
            searchImage.widthAnchor.constraint(equalToConstant: 50),
            
            //titleSearch
            titleSearch.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 10),
            titleSearch.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 10),
            titleSearch.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
            
            //descriptionsSearch
            descriptionSearch.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 10),
            descriptionSearch.topAnchor.constraint(equalTo: titleSearch.bottomAnchor,constant: 3),
            descriptionSearch.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
            
            //priceSearch
            priceSearch.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 10),
            priceSearch.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -10),
            priceSearch.topAnchor.constraint(equalTo: descriptionSearch.bottomAnchor, constant: 5),
            
            //cartBagSearch
            cartBagSearch.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
            cartBagSearch.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -10),
            cartBagSearch.widthAnchor.constraint(equalToConstant: 30),
            cartBagSearch.heightAnchor.constraint(equalToConstant: 30),
            
        
        ])
        
    }
    
    private func style() {
        
        contentView.backgroundColor = UIColor(named: "LoginForm")
        searchView.layer.shadowColor = UIColor.black.cgColor
        searchView.layer.shadowOffset = .zero
        searchView.layer.shadowRadius = 10
        searchView.layer.shadowOpacity = 0.1
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(searchView)
        searchView.addSubview(searchImage)
        searchView.addSubview(titleSearch)
        searchView.addSubview(descriptionSearch)
        searchView.addSubview(priceSearch)
        searchView.addSubview(cartBagSearch)
        constraints()
        style()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }

}
