//
//  PasswordChangeViewModel.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import Foundation

class PasswordChangeViewModel {
    
    var changeSuccess: (() -> Void)?
    var showErrorAlert: ((String) -> Void)?
    
    var currentInputPassword = ""
    var newInputPassword = ""
    var reNewInputPassword = ""
    
    var isInputValid: Bool {
        return !currentInputPassword.isEmpty && newInputPassword.count >= 8 && newInputPassword == reNewInputPassword
    }
    
    func changePassword() {
        if currentInputPassword == newInputPassword {
            showErrorAlert?("현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.")
            return
        }
        
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmail") else {
            showErrorAlert?("사용자를 찾을 수 없습니다.")
            return
        }
        
        let checkResult = CoreDataManager.shared.checkPassword(email: userEmail, password: currentInputPassword)
        if let isCorrect = checkResult, isCorrect {
            let updateResult = CoreDataManager.shared.updatePassword(email: userEmail, newPassword: self.newInputPassword)
            if let isSuccess = updateResult, isSuccess {
                changeSuccess?()
            } else {
                showErrorAlert?("비밀번호 변경에 실패했습니다. 다시 시도해 주세요.")
            }
        } else if checkResult == false {
            showErrorAlert?("현재 비밀번호가 잘못되었습니다.")
        } else {
            showErrorAlert?("비밀번호 변경 중 오류가 발생했습니다.")
        }
    }
}
