//
//  SettingCollectionView.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit
import SnapKit

class SettingCollectionView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingCollectionView {
    private func setup() {
//        collectionView.isScrollEnabled = false
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: SettingCollectionViewCell.id)
        
    }
}


extension SettingCollectionView {
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
