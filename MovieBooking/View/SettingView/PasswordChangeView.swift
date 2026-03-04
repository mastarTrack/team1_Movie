//
//  PasswordChangeView.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit
import SnapKit

protocol PasswordChangeViewDelegate: AnyObject {
    func passwordFieldDidChange(current: String?, new: String?, reNew: String?)
    func didTapChangeButton()
}

class PasswordChangeView: UIView {
    
    weak var delegate: PasswordChangeViewDelegate?
    
    private let containerView = UIView()
    
    private let currentPasswordLabel = UILabel()
    private let newPasswordLabel = UILabel()
    private let reNewPasswordLabel = UILabel()
    
    private let currentPasswordField = CustomTextField(placeholder: "현재 비밀번호", isPassword: true)
    private let newPasswordField = CustomTextField(placeholder: "새 비밀번호", isPassword: true)
    private let reNewPasswordField = CustomTextField(placeholder: "새 비밀번호 확인", isPassword: true)
    
    private let changeButton = CustomButton(title: "비밀번호 변경")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PasswordChangeView {
    private func setAttributes() {
        containerView.layer.cornerRadius = 20
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        containerView.layer.borderWidth = 1
        
        [currentPasswordLabel, newPasswordLabel, reNewPasswordLabel].forEach {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .secondaryLabel
        }
        currentPasswordLabel.text = "현재 비밀번호"
        newPasswordLabel.text = "새 비밀번호"
        reNewPasswordLabel.text = "새 비밀번호 확인"
        
        
        changeButton.isEnabled = false
        changeButton.alpha = 0.5
    }
    
    private func setLayout() {
        [currentPasswordLabel, currentPasswordField, newPasswordLabel, newPasswordField, reNewPasswordLabel, reNewPasswordField].forEach { containerView.addSubview($0) }
        [containerView, changeButton].forEach { addSubview($0)}
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        currentPasswordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().offset(10)
        }
        
        currentPasswordField.snp.makeConstraints {
            $0.top.equalTo(currentPasswordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
        
        newPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(currentPasswordField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(10)
        }
        
        newPasswordField.snp.makeConstraints {
            $0.top.equalTo(newPasswordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
        
        reNewPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(newPasswordField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(10)
        }
        
        reNewPasswordField.snp.makeConstraints {
            $0.top.equalTo(reNewPasswordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(60)
        }
        
        changeButton.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}

extension PasswordChangeView {
    func setButtonEnbaled(isEnbaled: Bool) {
        changeButton.isEnabled = isEnbaled
        
        changeButton.alpha = isEnbaled ? 1 : 0.5
    }
}

extension PasswordChangeView {
    private func setAction() {
        [currentPasswordField, newPasswordField, reNewPasswordField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func textFieldDidChange() {
        delegate?.passwordFieldDidChange(current: currentPasswordField.text, new: newPasswordField.text, reNew: reNewPasswordField.text)
    }
    
    @objc
    private func changeButtonTapped() {
        delegate?.didTapChangeButton()
    }
}
