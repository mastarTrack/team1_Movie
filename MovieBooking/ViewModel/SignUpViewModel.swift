//
//  SignUpViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import Foundation

class SignUpViewModel {
    
    var showAlert: ((String, Bool) -> Void)?
    var passwordEqual: ((Bool) -> Void)?
    
    var isEmailChecked = false
    
    func emailChanged() {
            isEmailChecked = false
        }
    
    func signUp(name: String, email: String, password: String, rePassword: String) {
        guard !name.isEmpty else {
            showAlert?("이름을 입력해주세요.", false)
            return
        }
        guard !email.isEmpty else {
            showAlert?("이메일을 입력해주세요.", false)
            return
        }
        guard !password.isEmpty else {
            showAlert?("비밀번호를 입력해주세요.", false)
            return
        }
        guard password.count >= 8 else {
            showAlert?("비밀번호는 8자리 이상이어야 합니다.", false)
            return
        }
        guard password == rePassword else {
            showAlert?("비밀번호가 맞지 않습니다.", false)
            return
        }
        guard isEmailChecked else {
            showAlert?("이메일 중복 검사를 진행해 주세요..", false)
            return
        }
        let isSaved = CoreDataManager.shared.saveUser(
            name: name,
            email: email,
            password: password
        )
        if isSaved {
            showAlert?("회원가입에 성공했습니다.", true)
        } else {
            showAlert?("회원가입 중 오류가 발생했습니다. 잠시후 다시 시도해주세요.", false)
        }
    }
    
    func checkEmail(email: String) {
        guard !email.isEmpty else {
            showAlert?("이메일을 입력해주세요.", false)
            return
        }
        let userData = CoreDataManager.shared.isUserExist(email: email)
        switch userData {
        case .some(true):
            showAlert?("이미 존재하는 이메일입니다.", false)
            self.isEmailChecked = false
        case .some(false):
            showAlert?("사용 가능한 이메일입니다.", false)
            self.isEmailChecked = true
        case .none:
            showAlert?("서버 오류. 다시 시도해주세요.", false)
            self.isEmailChecked = false
        }
    }
    
    func isPasswordEqual(password: String, rePassword: String) {
        let result = (password == rePassword) && !rePassword.isEmpty
        passwordEqual?(result)
    }
    
}
