//
//  ViewController.swift
//  CombineExample
//
//  Created by gaeng on 2023/05/01.
//

import UIKit

class ViewController: UIViewController {
    lazy var idTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var passwordConfirmTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("가입", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemBackground
        self.setLayout()
    }
    
    private func setLayout() {
        [
            self.idTextField,
            self.passwordTextField,
            self.passwordConfirmTextField,
            self.signUpButton
        ].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [
            self.idTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150),
            self.idTextField.widthAnchor.constraint(equalToConstant: 200),
            self.idTextField.heightAnchor.constraint(equalToConstant: 50),
            self.idTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ].forEach {
            $0.isActive = true
        }
        
        [
            self.passwordTextField.topAnchor.constraint(equalTo: self.idTextField.bottomAnchor, constant: 20),
            self.passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            self.passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ].forEach {
            $0.isActive = true
        }
        
        [
            self.passwordConfirmTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20),
            self.passwordConfirmTextField.widthAnchor.constraint(equalToConstant: 200),
            self.passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 50),
            self.passwordConfirmTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ].forEach {
            $0.isActive = true
        }
        
        [
            self.signUpButton.topAnchor.constraint(equalTo: self.passwordConfirmTextField.bottomAnchor, constant: 20),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 200),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 50),
            self.signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ].forEach {
            $0.isActive = true
        }
    }
}

