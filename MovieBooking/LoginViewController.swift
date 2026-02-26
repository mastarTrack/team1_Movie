//
//  LoginViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
        setDelegate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

extension LoginViewController {
    private func setDelegate() {
        loginView.delegate = self
    }
}

extension LoginViewController: LoginViewDelegate {
    func didTapSignUpButton() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
