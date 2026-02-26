//
//  SignUpViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//TODO: 이메일 검사 이전에 가입버튼 클릭 시 이메일 검사를 진행해주세요. 출력 - 완료
//TODO: 이메일 검사 이후 값을 변경할 경우 다시 이메일 검사 진행하도록
//TODO: 회원가입 성공 시 CoreData 저장, LoginView로 돌아가기

import UIKit

class SignUpViewController: UIViewController {
    
    var isEmailChecked = false
    
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
        guard isEmailChecked else {
            showAlert(message: "이메일 중복 검사를 진행해 주세요.")
            return
        }
        
        let isSaved = CoreDataManager.shared.saveUser(
            name: name,
            email: email,
            password: password
        )
        
        if isSaved {
            showAlert(message: "회원가입에 성공했습니다.", success: true)
        } else {
            showAlert(message: "회원가입 중 오류가 발생했습니다. 잠시후 다시 시도해주세요.")
        }
    }
    
    func passwordFieldDidChange(isEqual: Bool) {
        signUpView.updateRePasswordColor(isEqual: isEqual)
    }
    
    func didTapCheckButton(email: String) {
        guard !email.isEmpty else {
            showAlert(message: "이메일을 입력해주세요.")
            return
        }
        
        let userData = CoreDataManager.shared.isUserExist(email: email)
        switch userData {
        case .some(true):
            showAlert(message: "이미 존재하는 이메일입니다.")
            self.isEmailChecked = false
        case .some(false):
            showAlert(message: "사용 가능한 이메일입니다.")
            self.isEmailChecked = true
        case .none:
            showAlert(message: "서버 오류. 다시 시도해주세요.")
            self.isEmailChecked = false
        }
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
