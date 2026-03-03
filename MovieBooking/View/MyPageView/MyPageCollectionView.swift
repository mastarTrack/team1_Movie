//
//  MyPageCollectionView.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

import UIKit
import SnapKit

enum MyPageSectionType: CaseIterable {
    case profile
    case menu
    case info
}

class MyPageCollectionView: UIView {
    lazy var collectionView  = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageCollectionView {
    private func setup() {
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.register(MyPageProfileCell.self, forCellWithReuseIdentifier: MyPageProfileCell.id)
        collectionView.register(MyPageMenuCell.self, forCellWithReuseIdentifier: MyPageMenuCell.id)
    }
}

extension MyPageCollectionView {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection in
            let sectionType = MyPageSectionType.allCases[sectionIndex]
            
            switch sectionType {
            case .profile:
                return self.createProfileSection()
            case .menu:
                return self.createMenuSection()
            case .info:
                return self.createProfileSection()
            }
        }
    }
}

extension MyPageCollectionView {
    private func createProfileSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return section
    }
    
    private func createMenuSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(85))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        return section
    }
}
