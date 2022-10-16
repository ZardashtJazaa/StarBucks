//
//  OnboardingCollectionViewCell.swift
//  SunGlass
//
//  Created by Zardasht on 10/2/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    static let idendtifier = String(describing: OnboardingCollectionViewCell.self)
    
    private let logoImage: UIImageView = {
       
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        logo.layer.cornerRadius = 10
        //logo.frame = CGRect(x: 0, y: 0,width: 10, height: 10)
        return logo
        
    }()
    
    private let titleLabel: UILabel =  {
    
        let title = UILabel()
        title.backgroundColor = .clear
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 22, weight: .heavy, width: .standard)
        title.lineBreakMode = .byWordWrapping
        return title
     }()
    
    private let descriptionsLabel: UILabel = {
       
        let descriptions = UILabel()
        descriptions.backgroundColor = .clear
        descriptions.translatesAutoresizingMaskIntoConstraints = false
        descriptions.textAlignment = .center
        descriptions.numberOfLines = 0
        descriptions.font.withSize(18)
        //descriptions.lineBreakMode = .byWordWrapping
        return descriptions
        
    }()
    
    
    private let onboardingImageView: UIImageView = {
       
        let onboardingImage = UIImageView()
        onboardingImage.contentMode = .scaleAspectFit
        return onboardingImage
    }()
    
    
    func configure(imageName:OnboardingImageNumber) {
        onboardingImageView.image  = UIImage(named: imageName.image)
        titleLabel.text = imageName.title
        descriptionsLabel.text = imageName.description
        logoImage.image = UIImage(named: imageName.iconImage)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        onboardingImageView.frame = contentView.bounds
        contentView.backgroundColor = UIColor(named: "Colors")
        constraints()
        //titleLabel.layoutIfNeeded()
//        contentView.backgroundColor = .white
       
        
    }
    
    private func constraints() {
        
        var titleLabelConstraints = [NSLayoutConstraint]()
        
        titleLabelConstraints += [NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: onboardingImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        
        titleLabelConstraints += [NSLayoutConstraint.init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: onboardingImageView, attribute: .top, multiplier: 1.0, constant: 140)]
        
        titleLabelConstraints += [NSLayoutConstraint.init(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: onboardingImageView, attribute: .width, multiplier: 1.0, constant: 0.0)]

        titleLabelConstraints += [NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)]


        
        var descriptionsLabelConstraints = [NSLayoutConstraint]()
        
        descriptionsLabelConstraints += [NSLayoutConstraint.init(item: descriptionsLabel, attribute: .centerX, relatedBy: .equal, toItem: onboardingImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        
        descriptionsLabelConstraints += [NSLayoutConstraint.init(item: descriptionsLabel, attribute: .top, relatedBy: .equal, toItem: onboardingImageView, attribute: .bottom, multiplier: 1.0, constant: -150)]
        
        descriptionsLabelConstraints += [NSLayoutConstraint.init(item: descriptionsLabel, attribute: .width, relatedBy: .equal, toItem: onboardingImageView, attribute: .width, multiplier: 1.0, constant: -10)]
        
        descriptionsLabelConstraints += [NSLayoutConstraint.init(item: descriptionsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150)]
        
        
        
        var logoImageConstraints = [NSLayoutConstraint]()
        
        logoImageConstraints += [NSLayoutConstraint.init(item: logoImage, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        
        logoImageConstraints += [NSLayoutConstraint.init(item: logoImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 20)]
        
        logoImageConstraints += [NSLayoutConstraint.init(item: logoImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 75)]
        
        logoImageConstraints += [NSLayoutConstraint.init(item: logoImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)]
        
        NSLayoutConstraint.activate(logoImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(descriptionsLabelConstraints)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(logoImage)
        contentView.addSubview(onboardingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionsLabel)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
}
