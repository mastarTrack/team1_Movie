//
//  LoginViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//TODO: 로그인 성공 시 화면 전환에 애니메이션 적용?
//TODO: 로그인 성공 시 UserDefaults에 저장 - 완료
//TODO: MVVM 적용

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()
    
    override func loadView() {
        self.view = loginView
        setDelegate()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

extension LoginViewController {
    private func bind() {
        viewModel.updateLoginStatus = { [weak self] message, success in
            self?.showAlert(message: message, success: success)
        }
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
    
    func didTapLoginButton(email: String, password: String) {
        viewModel.login(email: email, password: password)
    }
}

extension LoginViewController {
    private func showAlert(message: String, success: Bool = false) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            if success {
                let mainVC = ViewController()
                let navigationController = UINavigationController(rootViewController: mainVC)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
            }
        })
        present(alert, animated: true)
    }
}
