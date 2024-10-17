//
//  LoginViewController.swift
//  NedbankClone
//
//  Created by Nagarro on 2024/08/05.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // UI Components
    let logoImageView = UIImageView()
    let userEmailTextField = NDTextField()
    let userPasswordTextField = NDTextField()
    let callToActionButton = NDButton(backgroundColor: .systemGreen, title: "Login")
    
    // Error message property
    var errorMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureEmailTextfield()
        configurePasswordTextfield()
        configureCallToActionButton()
        createDissmisssKeyboardTapGesture() // Add this to dismiss keyboard
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // Method to create a tap gesture recognizer to dismiss the keyboard.
    func createDissmisssKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // Method to configure the logo image view.
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        
        // Layout constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // Validate user input
    private func validate() -> Bool {
        errorMessage = ""
        
        // Retrieve text from text fields
        guard let email = userEmailTextField.text, let password = userPasswordTextField.text else {
            errorMessage = "Error retrieving input."
            return false
        }
        
        // Check if fields are empty
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        // Validate email format
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        return true
    }

    // Configure the email text field
    func configureEmailTextfield() {
        view.addSubview(userEmailTextField)
        userEmailTextField.delegate = self
        userEmailTextField.placeholder = "Enter your email"
        
        // Layout constraints
        NSLayoutConstraint.activate([
            userEmailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userEmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userEmailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userEmailTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // Configure the password text field
    func configurePasswordTextfield() {
        view.addSubview(userPasswordTextField)
        userPasswordTextField.delegate = self
        userPasswordTextField.placeholder = "Enter your Password"
        userPasswordTextField.isSecureTextEntry = true // Hide password input
        
        // Layout constraints
        NSLayoutConstraint.activate([
            userPasswordTextField.topAnchor.constraint(equalTo: userEmailTextField.bottomAnchor, constant: 20),
            userPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    // Configure the call-to-action button
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(handleLoginButtonTap), for: .touchUpInside)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Handle login button tap
    @objc func handleLoginButtonTap() {
        if validate() {
            // Proceed with login
            print("Login successful")
        } else {
            // Show error message
            print("Error: \(errorMessage)")
        }
    }
}
