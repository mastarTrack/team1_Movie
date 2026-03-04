//
//  PasswordChangeViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
    private let passwordChangeView = PasswordChangeView()
    
    private var currentInputPassword = ""
    private var newInputPassword = ""
    private var reNewInputPassword = ""
    
    override func loadView() {
        self.view = passwordChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
}

extension PasswordChangeViewController {
    private func setDelegate() {
        passwordChangeView.delegate = self
    }
}

extension PasswordChangeViewController: PasswordChangeViewDelegate {
    func passwordFieldDidChange(current: String?, new: String?, reNew: String?) {
        guard let currentPassword = current, let newPassword = new, let reNewPassword = reNew else { return }
        self.currentInputPassword = currentPassword
        self.newInputPassword = newPassword
        self.reNewInputPassword = reNewPassword
        let isValid = !currentPassword.isEmpty && newPassword.count >= 8 && newPassword == reNewPassword
        
        passwordChangeView.setButtonEnbaled(isEnbaled: isValid)
    }
    
    func didTapChangeButton() {
        let alert = UIAlertController(title: "알림", message: "비밀번호가 변경하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            guard let userEmail = UserDefaults.standard.string(forKey: "userEmail") else { return }
            let checkResult = CoreDataManager.shared.checkPassword(email: userEmail, password: currentInputPassword)
            if let isCorrect = checkResult, isCorrect {
                let updateResult = CoreDataManager.shared.updatePassword(email: userEmail, newPassword: self.newInputPassword)
                if let isSuccess = updateResult, isSuccess {
                    showCompletionAlert()
                } else if checkResult == false {
                    showErrorAlert(message: "현재 비밀번호가 일치하지 않습니다.")
                } else {
                    showErrorAlert(message: "비밀번호 변경에 실패하였습니다.")
                }
            }
        })
        present(alert, animated: true)
    }
}

extension PasswordChangeViewController {
    private func showCompletionAlert() {
        let alert = UIAlertController(title: "완료", message: "비밀번호가 변경되었습니다. 다시 로그인해주십시오.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            let myPageVM = MyPageViewModel()
            myPageVM.removeUserData()
            self?.changeNavigationToLogin()
        })
        present(alert, animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    private func changeNavigationToLogin () {
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
