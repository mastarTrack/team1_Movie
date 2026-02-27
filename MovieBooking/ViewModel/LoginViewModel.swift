//
//  LoginViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import Foundation

class LoginViewModel {
    
    var updateLoginStatus: ((String, Bool) -> Void)?
    
    func login(email: String, password: String) {
        guard !email.isEmpty else {
            updateLoginStatus?("이메일을 입력해주세요.", false)
            return
        }
        guard !password.isEmpty else {
            updateLoginStatus?("비밀번호를 입력해주세요", false)
            return
        }
        let loginData = CoreDataManager.shared.login(email: email, password: password)
        switch loginData {
        case .some(true):
            UserDefaults.standard.set(true, forKey: "isLogin")
            UserDefaults.standard.set(email, forKey: "userEmail")
            updateLoginStatus?("로그인에 성공했습니다.", true)
        case .some(false):
            updateLoginStatus?("이메일과 비밀번호를 확인해주세요.", false)
        case .none:
            updateLoginStatus?("로그인 오류. 다시 시도해주세요.", false)
        }
    }
}
