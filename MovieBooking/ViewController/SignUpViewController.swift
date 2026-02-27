//
//  SignUpViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//TODO: 이메일 검사 이전에 가입버튼 클릭 시 이메일 검사를 진행해주세요. 출력 - 완료
//TODO: 이메일 검사 이후 값을 변경할 경우 다시 이메일 검사 진행하도록 - 완료
//TODO: 회원가입 성공 시 CoreData 저장, LoginView로 돌아가기 - 완료

import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private let viewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        bind()
    }
}

extension SignUpViewController {
    private func bind() {
        viewModel.showAlert = { [weak self] message, success in
            self?.showAlert(message: message, success: success)
        }
        viewModel.passwordEqual = { [weak self] result in
            self?.signUpView.updateRePasswordColor(isEqual: result)
            
        }
    }
}

extension SignUpViewController {
    private func setDelegate() {
        signUpView.delegate = self
    }
}

extension SignUpViewController: SignUpViewDelegate {
    
    
    func didTapSignUpButton(name: String, email: String, password: String, rePassword: String) {
        viewModel.signUp(name: name, email: email, password: password, rePassword: rePassword)
    }
    
    func passwordFieldDidChange(password: String, rePassword: String) {
        viewModel.isPasswordEqual(password: password, rePassword: rePassword)
    }
    
    func didTapCheckButton(email: String) {
        viewModel.checkEmail(email: email)
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
