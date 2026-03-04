//
//  PasswordChangeViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
    private let passwordChangeView = PasswordChangeView()
    
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
        
        let isValid = !currentPassword.isEmpty && newPassword.count >= 8 && newPassword == reNewPassword
        
        passwordChangeView.setButtonEnbaled(isEnbaled: isValid)
    }
    
    func didTapChangeButton() {
        print("Test~~")
    }
}
