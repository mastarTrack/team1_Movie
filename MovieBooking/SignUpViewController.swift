//
//  SignUpViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
}

extension SignUpViewController {
    private func setDelegate() {
        signUpView.delegate = self
    }
}

extension SignUpViewController: SignUpViewDelegate {
    func didTapSignUpButton(name: String, email: String, password: String, rePassword: String) {
        
        guard !name.isEmpty else {
            showAlert(message: "이름을 입력해주세요.")
            return
        }
        guard !email.isEmpty else {
            showAlert(message: "이메일을 입력해주세요.")
            return
        }
        guard !password.isEmpty else {
            showAlert(message: "비밀번호를 입력해주세요.")
            return
        }
        guard password.count >= 8 else {
            showAlert(message: "비밀번호를 8자리 이상이어야 합니다.")
            return
        }
        guard password == rePassword else {
            showAlert(message: "비밀번호가 맞지않습니다.")
            return
        }
        
        showAlert(message: "회원가입에 성공했습니다.", success: true)
    }
}

extension SignUpViewController {
    private func showAlert(message: String, success: Bool = false) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            if success {
                self.navigationController?.popViewController(animated: true)
            }
        })
        present(alert, animated: true)
    }
}
