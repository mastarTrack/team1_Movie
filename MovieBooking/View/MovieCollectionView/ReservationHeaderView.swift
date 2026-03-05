//
//  ReservationHeaderView.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit
import SnapKit

class ReservationHeaderView: UICollectionReusableView {
    static let id = "ReservationHeaderView"
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReservationHeaderView {
    private func setup() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

extension ReservationHeaderView {
    func config(title: String) {
        titleLabel.text = title
    }
}
