//
//  SignUpView.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit
import SnapKit

//TODO: 회원가입 버튼 클릭 시 조건에 따라 alert, 비밀번호 확인 버튼 생성 및 로직 구현

protocol SignUpViewDelegate: AnyObject {
    func didTapSignUpButton(name: String, email: String, password: String, rePassword: String)
    func passwordFieldDidChange(isEqual: Bool)
}

class SignUpView: UIView {
    
    weak var delegate: SignUpViewDelegate?
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let nameField = CustomTextField(placeholder: "이름")
    private let emailField = CustomTextField(placeholder: "이메일")
    private let checkButton = CustomButton(title: "중복 확인")
    private let passwordField = CustomTextField(placeholder: "비밀번호 (8자 이상)", isPassword: true)
    private let rePasswordField = CustomTextField(placeholder: "비밀번호 확인", isPassword: true)
    private let signUpButton = CustomButton(title: "가입하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setAttributes()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpView {
    private func setAttributes() {
        
        titleLabel.text = "Movie Booking"
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "즐거운 여가생활, Movie Booking과 함께 시작하세요."
        subtitleLabel.textColor = .systemGray2
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
    }
    
    private func setLayout() {
        
        [titleLabel, subtitleLabel, nameField, emailField, checkButton, passwordField, rePasswordField, signUpButton].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nameField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(checkButton.snp.leading).offset(-10)
            $0.height.equalTo(50)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        rePasswordField.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(rePasswordField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        
    }
}

extension SignUpView {
    private func setAction() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        passwordField.textField.addTarget(self, action: #selector(passwordFieldDidChange), for: .editingChanged)
        rePasswordField.textField.addTarget(self, action: #selector(passwordFieldDidChange), for: .editingChanged)
    }
    
    @objc
    private func signUpButtonTapped() {
        delegate?.didTapSignUpButton(
            name: nameField.text ?? "",
            email: emailField.text ?? "",
            password: passwordField.text ?? "",
            rePassword: rePasswordField.text ?? ""
        )
    }
    
    @objc
    private func passwordFieldDidChange() {
        let password = passwordField.textField.text ?? ""
        let rePassword = rePasswordField.textField.text ?? ""
        
        delegate?.passwordFieldDidChange(isEqual: password == rePassword && !rePassword.isEmpty)
    }
    
    func updateRePasswordColor(isEqual: Bool) {
        if isEqual {
            rePasswordField.layer.borderWidth = 1
            rePasswordField.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            rePasswordField.layer.borderWidth = 1
            rePasswordField.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
}

