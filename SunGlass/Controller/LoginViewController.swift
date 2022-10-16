//
//  LoginViewController.swift
//  SunGlass
//
//  Created by Zardasht on 10/3/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class LoginViewController: UIViewController {

    //MARK: - Properety
    let stackView = UIStackView()
    let emailFormView = EmailFormView()
    let passowrdFormView = PasswordFormView()
    let titleLabel = makeUilabel(with: "Starbucks")
    let logoImageView = makeUiImage(with: "logo")
    let loginButton = makeButton(with: "Login")
    
    let gradiantView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    
    
    let bag = DisposeBag()
    
    private func email_password_Validations() {
        
        let emailObservable = emailFormView.emailTextField.rx.text.orEmpty
        let passwordObservable = passowrdFormView.passwordTextField.rx.text.orEmpty
        
        let combinedObservable = Observable.combineLatest(emailObservable , passwordObservable)
        loginButton.rx.tap
            .withLatestFrom(combinedObservable)
            .subscribe(onNext: { [weak self] emitedEmail , emitedPassword in
                self?.isLoginValid(email: emitedEmail, password: emitedPassword)
            })
            .disposed(by: bag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        style()
        layout()
        email_password_Validations()
    }

}

//MARK: - Style
extension LoginViewController  {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        emailFormView.translatesAutoresizingMaskIntoConstraints = false
        passowrdFormView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        gradiantView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
//        let screenTap = UITapGestureRecognizer(target: self, action: #selector(emailAndPasswordUndo))
//        self.view.addGestureRecognizer(screenTap)
        
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [emailFormView,passowrdFormView] _ in
                emailFormView.undo()
                passowrdFormView.undo()
            })
            .disposed(by: bag)
        
        
        let gradient = CAGradientLayer()

        gradient.frame = gradiantView.bounds
        gradient.colors = [UIColor.white.cgColor,UIColor(named: "GradiantDownColor")!.cgColor,UIColor(named: "GradiantDownColor")!.cgColor,UIColor.white.cgColor]
        gradient.locations = [0.0 , 0.4 , 0.9 , 1.0]
        gradiantView.layer.addSublayer(gradient)
        
    }
    //MARK: - Layout
    func layout() {
        view.addSubview(logoImageView)
        view.addSubview(emailFormView)
        view.addSubview(passowrdFormView)
        view.addSubview(gradiantView)
        view.addSubview(titleLabel)
        
        stackView.addArrangedSubview(emailFormView)
        stackView.addArrangedSubview(passowrdFormView)
        stackView.addArrangedSubview(loginButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            //stackView
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //emailFormView
            emailFormView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: emailFormView.trailingAnchor, multiplier: 2),
            //passwordFormView
            passowrdFormView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passowrdFormView.trailingAnchor, multiplier: 2),
            //LoginButton
            loginButton.widthAnchor.constraint(equalTo: passowrdFormView.widthAnchor),
            loginButton.heightAnchor.constraint(equalTo: passowrdFormView.heightAnchor),
           
            //LogoImageView
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            gradiantView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: gradiantView.trailingAnchor, multiplier: 0),
            gradiantView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 10),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
}

//MARK: - Factoties

func makeButton(with text:String) -> UIButton {

    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Login", for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets =  UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = UIColor(named: "Loginbutton")
    button.layer.cornerRadius = 15
    return button
    
}

func makeUiImage(with imageName:String) -> UIImageView {
    
    let image = UIImageView()
    image.image = UIImage(named: imageName)
    //image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
    
}

func makeUilabel(with titleName:String) -> UILabel {
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 22)
    label.text = titleName
    label.textColor = UIColor(named: "Colors")
    label.textAlignment = .center
    
    
    return label
}

//MARK: - Actions Undo
//extension LoginViewController {
//
//    @objc func emailAndPasswordUndo() {
//
//        self.emailFormView.undo()
//        self.passowrdFormView.undo()
//    }
//}

//MARK: - Validations

extension LoginViewController {
    
    func isLoginValid(email:String , password:String)  {
        
        let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailText = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        let emailValid : Bool = emailText.evaluate(with: email)
        let passwordValid : Bool = (password != "" && password.count >= 1)
        
        if emailValid && passwordValid {
//            self.emailAndPasswordUndo()
            print("Email & PAssword is valid")
            
            let mainView = TabBarController()
            mainView.firstViewController = UINavigationController(rootViewController: HomeViewController())
            mainView.modalPresentationStyle = .fullScreen
            self.present(mainView, animated: true)
            
        } else {
            print("Invalid Email Or Password!")
            
        }
    }
    
}
