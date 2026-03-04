//
//  BookingSectionHeaderView.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/4/26.
//
import UIKit
import SnapKit

final class BookingSectionHeaderView: UICollectionReusableView {
    static let identifier = "BookingSectionHeaderView"
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
