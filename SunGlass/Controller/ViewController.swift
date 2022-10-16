//
//  ViewController.swift
//  SunGlass
//
//  Created by Zardasht on 10/2/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    
    let bag = DisposeBag()
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            if  currentPage == onboardPageNumber.value.count - 1 {
                NextButton.setTitle("Get Started", for: .normal)
            } else {
                NextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    let onboardPageNumber = BehaviorRelay.init(value: [OnboardingImageNumber.init(image: "card"
                                                                                  ,title: "Gift Cards in Bulk"
                                                                                  
                                                                                  ,  description: "There’s an easier way to buy Starbucks Cards in bulk! Give a Starbucks Card to gift, reward,incentivize",iconImage: "logo")
                                                       ,OnboardingImageNumber.init(image: "bucks"
                                                                                   ,title: "Nitro all fall long"
                                                                                   , description: "Ready on tap, super-smooth Nitro Cold Brew. For a silky twist try Vanilla Sweet Cream Nitro Cold Brew.",iconImage: "logo")
                                                       ,OnboardingImageNumber.init(image: "two"
                                                                                   ,title: "Fall at your fingertips"
                                                                                   , description: "Ordering your fall favorites is a snap with the app. Join Starbucks® Rewards and tap into fall.",iconImage: "logo")])
    
    //MARK: - Observable
    private func observable() {
        
        onboardPageNumber
            .bind(to: uicollection.rx.items(cellIdentifier: OnboardingCollectionViewCell.idendtifier , cellType: OnboardingCollectionViewCell.self)) {
                (index, collectionItems , cell) in
                
                cell.configure(imageName: collectionItems)
                
            }
            .disposed(by: bag)
        uicollection.rx.setDelegate(self).disposed(by: bag)
        NextButton.rx.tap
            .subscribe(onNext:  { [weak self ] _ in
                if self?.currentPage == ((self?.onboardPageNumber.value.count)!) - 1 {
                    let login = LoginViewController()
                    login.modalPresentationStyle = .fullScreen
                    login.modalTransitionStyle = .crossDissolve
                    self?.present(login, animated: true)
                } else {
                    self?.currentPage += 1
                    let indexPath = IndexPath(item: self!.currentPage, section: 0)
                    self?.uicollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
                
            }).disposed(by: bag)
    }
    
    
    private let pageController: UIPageControl = {
        
        let pageCounter = UIPageControl()
        pageCounter.translatesAutoresizingMaskIntoConstraints = false
        pageCounter.backgroundColor = .clear
        pageCounter.pageIndicatorTintColor = .white
        pageCounter.currentPageIndicatorTintColor = UIColor(named: "currentPageColor")
        pageCounter.layer.cornerRadius = 10
        pageCounter.isUserInteractionEnabled = false
        return pageCounter
        
    }()
    
    private let NextButton: UIButton = {
        
        let next = UIButton()
        next.translatesAutoresizingMaskIntoConstraints = false
        next.layer.cornerRadius = 10
        next.backgroundColor = .white
        next.setTitle("Next", for: .normal)
        next.setTitleColor(UIColor(named: "Colors"), for: .normal)
        return next
    }()
    
    private let uicollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        lazy var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.idendtifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        pageController.numberOfPages = onboardPageNumber.value.count
        observable()
        view.backgroundColor = UIColor(named: "Colors")
        view.addSubview(uicollection)
        view.addSubview(pageController)
        view.addSubview(NextButton)
        constraints()
        
        //uicollection.dataSource = self
    }
    
    //MARK: - Constraints
    func constraints() {
        var uicollectionViewConstraints = [NSLayoutConstraint]()
        
        uicollectionViewConstraints += [NSLayoutConstraint.init(item: uicollection, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)]
        uicollectionViewConstraints += [NSLayoutConstraint.init(item: uicollection, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)]
        uicollectionViewConstraints += [NSLayoutConstraint.init(item: uicollection, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 5)]
        uicollectionViewConstraints += [NSLayoutConstraint.init(item: uicollection, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -150)]
        
        var pageControllerConstraints = [NSLayoutConstraint]()
        pageControllerConstraints += [NSLayoutConstraint.init(item: pageController, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        pageControllerConstraints += [NSLayoutConstraint.init(item: pageController, attribute: .top, relatedBy: .equal, toItem: uicollection, attribute: .bottom, multiplier: 1.0, constant: 30)]
        
        var nextButtonConstraints = [NSLayoutConstraint]()
        nextButtonConstraints += [NSLayoutConstraint.init(item: NextButton, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1.0, constant: 0.0)]
        nextButtonConstraints += [NSLayoutConstraint.init(item: NextButton, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: -20)]
        nextButtonConstraints += [NSLayoutConstraint.init(item: NextButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.frame.width / 2 + 50)]
        nextButtonConstraints += [NSLayoutConstraint.init(item: NextButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)]
        
        NSLayoutConstraint.activate(nextButtonConstraints)
        NSLayoutConstraint.activate(uicollectionViewConstraints)
        NSLayoutConstraint.activate(pageControllerConstraints)
    }
    
    
}

//MARK: - Delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageController.currentPage = currentPage
    }
    
}



