//
//  FormFieldView.swift
//  SunGlass
//
//  Created by Zardasht on 10/3/22.
//

import UIKit

class EmailFormView: UIView {
    
    //MARK: - Porperety
    
    let emaillabel = UILabel()
    let invalidEmail = UILabel()
    let emailTextField = UITextField()
    let cancelEmailButton = makeSymboleButton(systemName: "clear.fill", target: self, selector: #selector(cancelTapped(_:)))
    
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

//MARK: - Style
extension EmailFormView {
    
    func setup() {
        emailTextField.delegate = self
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "Loginform")
        layer.cornerRadius = 15
        
        //emailLabel
        emaillabel.translatesAutoresizingMaskIntoConstraints = false
        emaillabel.textColor = .systemGray
        emaillabel.text = "Email"
        
        //invalidEmail
        invalidEmail.translatesAutoresizingMaskIntoConstraints = false
        invalidEmail.textColor = .systemRed
        invalidEmail.text = "Email Is invalid"
        invalidEmail.font = UIFont.preferredFont(forTextStyle: .caption1)
        invalidEmail.isHidden = true
        
        //emailTextField
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.tintColor = .systemGreen
        emailTextField.keyboardType = .emailAddress
        emailTextField.isHidden = true
        emailTextField.textColor = .systemGray
        
        //cancelEmailButton
        cancelEmailButton.translatesAutoresizingMaskIntoConstraints = false
        cancelEmailButton.imageView?.tintColor = .systemGray
        cancelEmailButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        addGestureRecognizer(tap)
        
        
        
    }
    //MARK: - Layout
    
    func layout() {
        
        addSubview(emaillabel)
        addSubview(invalidEmail)
        addSubview(emailTextField)
        addSubview(cancelEmailButton)
        
        NSLayoutConstraint.activate([
            
            //emailLabel
            emaillabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emaillabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            //invalidEmail
            invalidEmail.topAnchor.constraint(equalTo: topAnchor,constant: 6),
            invalidEmail.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            //emailTextField
            emailTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: emailTextField.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: emailTextField.bottomAnchor, multiplier: 2),
            
            //cancelEmailButton
            cancelEmailButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: cancelEmailButton.trailingAnchor, multiplier: 2),
            
        ])
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        
        if (recognizer.state == UITapGestureRecognizer.State.ended) {
            eneterEmailAnimation()
          
        }
    }
    
    
}

//MARK: - Animations

extension EmailFormView {
    
    
    func eneterEmailAnimation() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: []) {
            
            
            //Style
            self.backgroundColor = .white
            self.emaillabel.textColor = .systemGreen
            self.layer.borderWidth = 1
            self.layer.borderColor = self.emaillabel.textColor.cgColor
            
            
            //move
            let transpose = CGAffineTransform(translationX: -8, y: -24)
            let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.emaillabel.transform = transpose.concatenating(scale)
            
            
            
        } completion: { [weak self ] positons in
            guard let self = self else { return}
            self.emailTextField.isHidden = false
            self.emailTextField.becomeFirstResponder()
            self.cancelEmailButton.isHidden = false
            
        }
    }
    
}

//MARK: - Undo Actions

extension EmailFormView {
    
    @objc func undo() {
        
        let size = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            
            //style
            self.backgroundColor = UIColor(named: "Loginform")
            self.emaillabel.textColor = .systemGray
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
            self.emailTextField.selectedTextRange = nil
            
            //visibility
            self.emailTextField.isHidden = true
            self.cancelEmailButton.isHidden  = true
            self.invalidEmail.isHidden = true
            self.emaillabel.isHidden = false
            self.emailTextField.tintColor = .systemGreen
            self.emailTextField.resignFirstResponder()
            //move
            self.emaillabel.transform = .identity  // identity is mean that we back to the initial state that we have been before!
        }
        size.startAnimation()
    }
    
    @objc func cancelTapped(_ sender: UIButton) {

        emailTextField.resignFirstResponder() // mean i dont want this things anymore!
        emailTextField.text = ""
        undo()
    }
    
}

//MARK: - EmailTextFieldDelegate

extension EmailFormView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let emailTextField = textField.text else { return }
        
        if chekEmail(email: emailTextField) {
            undo()
        } else {
            showInvalidEmailMessage()
        }
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if emailTextField.text != "" || emailTextField.text == ""  {
            
            return true
        }
        return false
    }

}

//MARK: - Factories

func makeSymboleButton(systemName: String , target: Any , selector:Selector) -> UIButton {
    
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(target, action: selector, for: .primaryActionTriggered)
    button.setImage(image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    return button
    
}

//MARK: - invalidEmail

extension EmailFormView {
    
    func chekEmail(email:String) -> Bool {
        
        let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailText = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        let emailValid : Bool = emailText.evaluate(with: email)
        return emailValid
    }
    
    
    func showInvalidEmailMessage()  {
        
        emaillabel.isHidden = true
        invalidEmail.isHidden = false
        layer.borderColor = UIColor.systemRed.cgColor
        emailTextField.tintColor = .systemRed
        
    }
}
