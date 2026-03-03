//
//  MovieCollectionView.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 2/26/26.
//
import UIKit
import SnapKit
import Then
import Kingfisher

final class MovieCollectionView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(collectionView)
        
        collectionView.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.identifier)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            let spacing: CGFloat = 10 // 간격
            
            let containerSize = environment.container.effectiveContentSize // 컬렉션뷰가 들어갈 사이즈 자동계산
            let itemWidthSize = (containerSize.width - spacing * 4) / 2// 들어갈 간격 제외한 아이템 크기 계산
            let itemHeightSize = itemWidthSize * 1.5
            
            let item = NSCollectionLayoutItem( // 아이템 크기 설정
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidthSize),
                    heightDimension: .absolute(itemHeightSize)
                )
            )
            
            let groupWidth = itemWidthSize * 2 + spacing // 한 화면에 두개
            let groupHeight = itemHeightSize // 높이는 같게
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .absolute(groupWidth),
                    heightDimension: .absolute(groupHeight)
                ),
                repeatingSubitem: item,
                count: 2 // 두개 넣어줌
            )
            
            group.interItemSpacing = .fixed(spacing)// 그룹 내에서의 간격
            
            // 그룹 밖의 간격
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
            
            // 섹션 묶기
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous // 스크롤 설정
            section.interGroupSpacing = spacing // 섹션 내부 간격
            
            
            // 섹션의 경계에 붙는 아이템
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0), // 화면 폭 전체 사용
                    heightDimension: .absolute(60) // 헤더 높이 고정
                ),
                elementKind: UICollectionView.elementKindSectionHeader, // 보조뷰 헤더로 설정
                alignment: .top // 위에 붙임
            )
            
            section.boundarySupplementaryItems = [header] // 해당 섹션에 붙는 보조뷰들 추가함
            
            return section
        })
    }
}
