//
//  ReviewCollectionView.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit
import SnapKit

protocol ReviewCollectionViewDelegate: AnyObject {
    func didChangeSegment(index: Int)
}

class ReviewCollectionView: UIView {
    
    weak var delegate: ReviewCollectionViewDelegate?
    
    private let segmentControl = UISegmentedControl(items: ["작성한 리뷰", "작성 가능"])
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
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

extension ReviewCollectionView {
    
    private func setAttributes() {
        segmentControl.selectedSegmentIndex = 0
        
    }
    
    private func setLayout() {
        
        [segmentControl, collectionView].forEach{ addSubview($0) }
        
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ReviewCollectionView {
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
            section.interGroupSpacing = 20
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
}

extension ReviewCollectionView {
    private func setAction() {
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc
    private func segmentChanged(sender: UISegmentedControl) {
        delegate?.didChangeSegment(index: sender.selectedSegmentIndex)
    }
}

