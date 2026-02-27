//
//  LoginViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//TODO: 로그인 성공 시 화면 전환에 애니메이션 적용?

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
    
    func didTapLoginButton(email: String, password: String) {
        guard !email.isEmpty else {
            showAlert(message: "이메일을 입력해주세요.")
            return
        }
        guard !password.isEmpty else {
            showAlert(message: "비밀번호를 입력해주세요")
            return
        }
        
        let loginData = CoreDataManager.shared.login(email: email, password: password)
        switch loginData {
        case .some(true):
            showAlert(message: "로그인에 성공했습니다.", success: true)
        case .some(false):
            showAlert(message: "이메일과 비밀번호를 확인해주세요.")
        case .none:
            showAlert(message: "로그인 오류. 다시 시도해주세요.")
        }
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
