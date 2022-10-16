//
//  HomeViewController.swift
//  SunGlass
//
//  Created by Zardasht on 10/4/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class HomeViewController: UIViewController {
    
    let tabBar = TabBarView()
    let searchView = SearchView()
    let trendingView = TrendingNowView()
    let popularView = PopularView()
    let searchTextField = makeUiTextFiel(placeHolder: "Search for coffee,snacks...")
    let searchButton = makeSearchButton(name: "magnifyingglass")
    let scrollView = UIScrollView()
    let TrendingLabel = makeLabel(name: "Trending Now")
    let PopularProduct = makeLabel(name: "Pupular Products")
    let textController = TextViewController()
    
    
    let bag = DisposeBag()
    let resuslt2 = BehaviorRelay<[StarBucks1]>(value: [])
    let resultBucks = BehaviorRelay<[StarBucks]>(value: [])
    let network = Api()
    
    
    //MARK: - Todo  Preventing sending request Each time in viewDidload!!
    
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        searchTextField.rx.controlEvent(.editingDidEnd)
            .subscribe { [textController] _ in
                
                textController.modalPresentationStyle = .formSheet
                self.present(textController, animated: true)
                
            }.disposed(by: bag)
        

        searchTextField.rx.text.orEmpty
            .map { [resultBucks ] String in
//                guard let self = self else { return }
                
                 resultBucks.value.flatMap { StarBucks -> [(StarBucks,Result)] in
                    StarBucks.results.map { (StarBucks,$0)}
                }.filter { (StarBucks, Result) in
                    String.isEmpty || Result.name.lowercased().contains(String.lowercased())
                }
            }.bind(to: textController.tableView.rx.items(cellIdentifier: searchTableViewCell.identifier,cellType: searchTableViewCell.self))  {
                ( tableView , item , cell ) in
                cell.configureSearchCell(imageName: item.1.imageUrl, title: item.1.name, descriptions: item.1.brand, price: item.1.price)
            }.disposed(by: bag)
        
        
        DispatchQueue.main.async {
            self.showSpinner()
        }
        // print("I am RUnning Now In Homee")
        print("Count \(RxSwift.Resources.total)")
        network.makeRequest()
            .subscribe(onNext: { [ resuslt2] data in
                
                do {
                    
                    let decoder = try JSONDecoder().decode(StarBucks1.self, from: data)
                    resuslt2.accept([decoder])
                    
                    
                }catch {
                    print(error.localizedDescription)
                }
            },onCompleted: {
                DispatchQueue.main.async  {
                    self.removeSpinner()
                }
            })
            .disposed(by: bag)
            
        
        
        
        network.makeRequestBucks()
            .subscribe(onNext: { [resultBucks] data in
                
                do {
                    let decoder = try JSONDecoder().decode(StarBucks.self, from: data)
                    resultBucks.accept([decoder])
                    //print(decoder)
                } catch  {
                    print(error.localizedDescription)
                }
                
            },onCompleted: {
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
            })
            .disposed(by: bag)
        
        //Trending
        resultBucks.map { bucks in
            bucks.flatMap { buck -> [(StarBucks,Result)] in
                buck.results.map { (buck,$0) }
            }
        }
        .bind(to: trendingView.trendingCollection.rx.items(cellIdentifier: TrendingCollectionViewCell.identifier,cellType: TrendingCollectionViewCell.self)) {
            (index , item , cell) in
            
            cell.configureImageCell(imageName: item.1.imageUrl, title: item.1.name, descriptions: item.1.brand, price: item.1.price)
        }.disposed(by: bag)
        
        Popular()
        style()
        layout()
        
    }
    
    private func Popular()  {
        //Popular
        resuslt2
            .map { starBucks in
                starBucks.flatMap { bucks -> [[[(Childrens, Products)]]] in
                    bucks.menus[2].children.map { menu1 in
                        menu1.children.map { menu2 in
                            menu2.products.map { (menu2 , $0) }
                        }
                    }
                }
            }.bind(to: popularView.popularCollection.rx.items(cellIdentifier: PopularCollectionViewCell.identifier, cellType: PopularCollectionViewCell.self)) {
                
                (index , item , cell) in
                let uri = item.first?.first?.1.assets.masterImage.uri
                cell.configurations(image: uri ?? "", title: item.first?.first?.1.name ?? "", description: "Nothing", price: "10.00")
            }.disposed(by: bag)
    }
    
    func style() {
        
        view.backgroundColor = UIColor(named: "HomeColorBackground")
        navigationItem.title = "Home"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "cart.circle.fill"), target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Colors")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "list.bullet"), target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "Colors")
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        TrendingLabel.translatesAutoresizingMaskIntoConstraints = false
        PopularProduct.translatesAutoresizingMaskIntoConstraints = false
        trendingView.translatesAutoresizingMaskIntoConstraints  = false
        popularView.translatesAutoresizingMaskIntoConstraints = false
        
        //ScrollView
        scrollView.backgroundColor =  UIColor(named: "HomeColorBackground")
        scrollView.isScrollEnabled = true
        
        
    }
    
    
    func layout() {
        
        view.addSubview(searchView)
        searchView.addSubview(searchButton)
        searchView.addSubview(searchTextField)
        view.addSubview(scrollView)
        scrollView.addSubview(TrendingLabel)
        scrollView.addSubview(trendingView)
        scrollView.addSubview(PopularProduct)
        scrollView.addSubview(popularView)
        //view.addSubview(tabBar)
        
        NSLayoutConstraint.activate([
            
            //TabBar
            //tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            //tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            //tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            //SearchView
            searchView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchView.trailingAnchor, multiplier: 3),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            //SearchButton
            searchButton.leadingAnchor.constraint(equalTo: searchView.leadingAnchor,constant: 10),
            searchButton.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            //SearchTextField
            searchTextField.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor,constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor,constant: -10),
            searchTextField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            //ScrollView
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: searchView.bottomAnchor,constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //TrendingLabel
            TrendingLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 3),
            scrollView.trailingAnchor.constraint(equalToSystemSpacingAfter: TrendingLabel.trailingAnchor, multiplier: 2),
            TrendingLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 20),
            //TrendingView
            trendingView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor,constant: 10),
            //            trendingView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            trendingView.topAnchor.constraint(equalTo: TrendingLabel.bottomAnchor, constant: 10),
            //            trendingView.widthAnchor.constraint(equalTo: view.widthAnchor),
            //PopularProduct
            PopularProduct.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 3),
            scrollView.trailingAnchor.constraint(equalToSystemSpacingAfter: PopularProduct.trailingAnchor, multiplier: 2),
            PopularProduct.topAnchor.constraint(equalTo: trendingView.bottomAnchor,constant: 30),
            //PopularView
            popularView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor,constant: 10),
            //            popularView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            popularView.topAnchor.constraint(equalTo: PopularProduct.bottomAnchor, constant: 10),
            //popularView.widthAnchor.constraint(equalTo: view.widthAnchor),
            // popularView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
            
            
        ])
    }
    
    
}


//MARK: - Factories

func makeUiTextFiel(placeHolder:String) -> UITextField {
    
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textAlignment = .center
    textField.contentMode = .center
    textField.font = textField.font?.withSize(13)
    textField.textColor = .gray
    textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
    textField.tintColor = .gray
    return textField
    
}

func makeSearchButton(name:String) -> UIButton {
    
    let button = UIButton()
    button.setImage(UIImage(systemName: name), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .gray
    button.isEnabled = false
    return button
    
}

func makeLabel(name:String) -> UILabel {
    
    let label = UILabel()
    label.text = name
    label.textColor = .black
    label.font = label.font.withSize(20)
    label.numberOfLines = 1
    return label
    
}

