//
//  SettingCollectionViewCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit
import SnapKit

protocol SettingCollectionViewCellDelegate: AnyObject {
    func didTapToggleSwitch(isDarkMode: Bool)
}

class SettingCollectionViewCell: UICollectionViewCell {
    
    static let id = "SettingCollectionViewCell"
    
    weak var delegate: SettingCollectionViewCellDelegate?
    
    private let iconBackgroundView = UIView()
    private let iconView = UIImageView()
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let stackView = UIStackView()
    
    private let infoLabel = UILabel()
    
    private let toggleSwitch = UISwitch()
    
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

extension SettingCollectionViewCell {
    private func setAttributes() {
        contentView.backgroundColor = .secondarySystemGroupedBackground
        
        iconBackgroundView.layer.cornerRadius = 20
        
        iconView.tintColor = .systemOrange
        iconView.contentMode = .scaleAspectFit
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .label
        
        subTitleLabel.font = .systemFont(ofSize: 12)
        subTitleLabel.textColor = .secondaryLabel
        
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.textColor = .secondaryLabel
        
        
    }
    
    private func setLayout() {
        [iconBackgroundView, stackView, infoLabel, toggleSwitch].forEach { contentView.addSubview($0) }
        iconBackgroundView.addSubview(iconView)
        [titleLabel, subTitleLabel].forEach { stackView.addArrangedSubview($0) }
        
        iconBackgroundView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        iconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(iconBackgroundView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        toggleSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
    }
}

extension SettingCollectionViewCell {
    func config(title: String, subTitle: String?, iconName: String?, infoText: String?, hasSwitch: Bool, isDarkMode: Bool) {
        
        titleLabel.text = title
        subTitleLabel.text = subTitle
        subTitleLabel.isHidden = subTitle == nil
        iconView.image = UIImage(systemName: iconName ?? "")
        
        if iconName == nil {
            iconBackgroundView.backgroundColor = .clear
        } else {
            iconBackgroundView.backgroundColor = .systemOrange.withAlphaComponent(0.1)
        }
        infoLabel.text = infoText
        
        toggleSwitch.isHidden = !hasSwitch
        toggleSwitch.isOn = isDarkMode
    }
}

extension SettingCollectionViewCell {
    private func setAction() {
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchTapped), for: .valueChanged)
    }
    
    @objc
    private func toggleSwitchTapped(sender: UISwitch) {
        delegate?.didTapToggleSwitch(isDarkMode: sender.isOn)
    }
}
