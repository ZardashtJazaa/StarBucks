//
//  PasswordFormView.swift
//  SunGlass
//
//  Created by Zardasht on 10/3/22.
//

import UIKit


class PasswordFormView: UIView {
    //MARK: - Properety
    
    let passowrdLabel = UILabel()
    let passwordTextField = UITextField()
    let invalidPassword = UILabel()
    
    let cancelPassowrdButton = makeSymboleButton(systemName: "clear.fill", target: self, selector: #selector(cancelTapped(_:)))
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Init Coder has Not been Implemented!")
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
        
    }

}

//MARK: -  style
extension PasswordFormView {
    
    func setup() {
        passwordTextField.delegate = self
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "Loginform")
        layer.cornerRadius = 15
        
        //passwordLabel
        passowrdLabel.translatesAutoresizingMaskIntoConstraints = false
        passowrdLabel.textColor = .systemGray
        passowrdLabel.text = "Password"
        
        //invalidPasswordLabel
        invalidPassword.translatesAutoresizingMaskIntoConstraints = false
        invalidPassword.textColor = .systemRed
        invalidPassword.text = "Password Is invalid"
        invalidPassword.font = UIFont.preferredFont(forTextStyle: .caption1)
        invalidPassword.isHidden = true
        
        //passowrdTextField
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.textColor = .systemGray
        passwordTextField.tintColor = .systemGreen
        passwordTextField.isHidden = true
        
        //CancelPassowrdButton
        cancelPassowrdButton.translatesAutoresizingMaskIntoConstraints = false
        cancelPassowrdButton.imageView?.tintColor = .systemGray
        cancelPassowrdButton.isHidden = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        addGestureRecognizer(tap)
        
        
    }
    
    //MARK: - Layout
    func layout() {
        
        addSubview(passowrdLabel)
        addSubview(invalidPassword)
        addSubview(passwordTextField)
        addSubview(cancelPassowrdButton)
        
        
        NSLayoutConstraint.activate([
            
            //emailLabel
            passowrdLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            passowrdLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            //invalidPassword
            invalidPassword.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            invalidPassword.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            //passwordTextField
            passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 2),
            
            //cancelPassowrdButton
            cancelPassowrdButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: cancelPassowrdButton.trailingAnchor, multiplier: 2),
        ])
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        
        if (recognizer.state == UITapGestureRecognizer.State.ended) {
            enterPasswordAnimation()
            
        }
    }
}

//MARK: - Animations

extension PasswordFormView {
    
    func enterPasswordAnimation() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: []) {
           
            //style
            self.backgroundColor = .white
            self.passowrdLabel.textColor = .systemGreen
            self.layer.borderWidth = 1
            self.layer.borderColor = self.passowrdLabel.textColor.cgColor
        
            //move
            let transpose = CGAffineTransform(translationX: -8, y: -24)
            let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.passowrdLabel.transform = transpose.concatenating(scale)
            
        } completion: { positions in
            
            self.passwordTextField.isHidden = false
            self.passwordTextField.becomeFirstResponder()
            self.passwordTextField.isSecureTextEntry = true
            self.cancelPassowrdButton.isHidden = false
            
        }
    }
}


//MARK: - Undo Actions

extension PasswordFormView {
    
    @objc func undo() {
       
        let size = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            
            //style
            self.backgroundColor = UIColor(named: "Loginform")
            self.passowrdLabel.textColor = .systemGray
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
            self.passwordTextField.selectedTextRange = nil
            
            //visibility
            self.passwordTextField.isHidden = true
            self.cancelPassowrdButton.isHidden = true
            self.invalidPassword.isHidden = true
            self.passowrdLabel.isHidden = false
            self.passwordTextField.tintColor = .systemGreen
            self.passwordTextField.resignFirstResponder()
            //move
            self.passowrdLabel.transform = .identity  // identity is mean that we back to the initial state that we have been before!
            
        }
        size.startAnimation()
    }
    
    @objc func cancelTapped(_ sender: UIButton) {
        passwordTextField.resignFirstResponder()
        passwordTextField.text = ""
        undo()
    }
    
}

//MARK: - PasswordTextFieldDelefate

extension PasswordFormView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)  {
       
        guard let passwordTextField = textField.text else { return }
        if chekPassword(password: passwordTextField) {
            undo()
        } else {
            showInvalidPasswordMessage()
        }
        
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if passwordTextField.text != "" || passwordTextField.text == "" {
            return true
        }
        return false
    }
   
}

//MARK: - InvalidPassword
extension PasswordFormView {
    
    func chekPassword(password:String) -> Bool {
        
        let passwordValid : Bool = (password != "" && password.count >= 1)
        return passwordValid
    }
    
    
    func showInvalidPasswordMessage()  {
        
        passowrdLabel.isHidden = true
        invalidPassword.isHidden = false
        layer.borderColor = UIColor.systemRed.cgColor
        passwordTextField.tintColor = .systemRed
        
    }
}



//MARK: - Questions

//question://
//when would you use .primaryActionTriggered vs. .touchUpInside?

//Answer://
//.primaryActionTriggered is not limited to buttons, but to controls in general. For most controls, it will trigger on .valueChanged, except for UIButton, where it is for .touchUpInside, and for UITextField where it is .didEndOnExit.

