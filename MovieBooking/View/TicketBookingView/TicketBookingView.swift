//
//  TicketBookingView.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/3/26.
//
import UIKit
import SnapKit

final class TicketBookingView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        registerCells()
        
        collectionView.register(
            BookingSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: BookingSectionHeaderView.identifier
        )
    }
    private func registerCells() {
        collectionView.register(
            CenterLabelCell.self,
            forCellWithReuseIdentifier: CenterLabelCell.identifier
        )

        collectionView.register(
            TripleLabelCell.self,
            forCellWithReuseIdentifier: TripleLabelCell.identifier
        )

        collectionView.register(
            TicketCountCell.self,
            forCellWithReuseIdentifier: TicketCountCell.identifier
        )
        
        collectionView.register(
            BookingCell.self,
            forCellWithReuseIdentifier: BookingCell.identifier
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.make2x2GirdSection(environment: environment)
            case 1:
                return self.makeHorizontalScrollSection(environment: environment)
            case 2:
                return self.make3x2GirdSection(environment: environment)
            case 3:
                return self.makeListSection(environment: environment)
            default:
                return self.makeBookingSection(environment: environment)
            }
        }
    }
}



// 레이아웃 구현 부
extension TicketBookingView {
    // 2*2 그리드
    private func make2x2GirdSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection{
        let spacing: CGFloat = 10
        
        // 컬렉션 뷰가 들어갈 사이즈 구하기
        let containerSize = environment.container.effectiveContentSize
        let itemWidthSize = (containerSize.width - spacing * 3) / 2
        
        // 가로폭만 계산해서 아이템 사이즈 계산
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidthSize),
            heightDimension: .absolute(50)
        )
        
        // 아이템 사이즈 지정
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 가로 한줄 구성
        let rowGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidthSize * 2),
                heightDimension: .absolute(50)
            ),
            repeatingSubitem: item,
            count: 2
        )
        
        rowGroup.interItemSpacing = .fixed(spacing)
        
        // 2번 쌓기
        let gridGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidthSize * 2),
                heightDimension: .absolute(100)
            ),
            repeatingSubitem: rowGroup,
            count: 2
        )
        
        gridGroup.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: gridGroup)
        section.interGroupSpacing = spacing
        
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.boundarySupplementaryItems = [makeHeaderItem(height: 60)]
        
        return section
    }
    
    // horizontal
    private func makeHorizontalScrollSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let spacing: CGFloat = 10
        
        let cellWidth: CGFloat = 80
        let cellHeight: CGFloat = 100
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .absolute(cellWidth),
                heightDimension: .absolute(cellHeight)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .absolute(cellWidth),
                heightDimension: .absolute(cellHeight)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        // 가로스크롤
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = spacing
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.boundarySupplementaryItems = [makeHeaderItem(height: 60)]

        return section
    }
    
    // 3*2
    private func make3x2GirdSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection{
        let spacing: CGFloat = 10
        
        // 컬렉션 뷰가 들어갈 사이즈 구하기
        let containerSize = environment.container.effectiveContentSize
        let itemWidthSize = (containerSize.width - spacing * 4) / 3
        
        // 가로폭만 계산해서 아이템 사이즈 계산
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidthSize),
            heightDimension: .absolute(50)
        )
        
        // 아이템 사이즈 지정
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 가로 한줄 구성
        let rowGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidthSize * 3),
                heightDimension: .absolute(50)
            ),
            repeatingSubitem: item,
            count: 3
        )
        
        rowGroup.interItemSpacing = .fixed(spacing)
        
        // 2번 쌓기
        let gridGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidthSize * 3),
                heightDimension: .absolute(100)
            ),
            repeatingSubitem: rowGroup,
            count: 2
        )
        
        gridGroup.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: gridGroup)
        section.interGroupSpacing = spacing
        
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.boundarySupplementaryItems = [makeHeaderItem(height: 60)]
        return section
    }
    
    // 두꺼운 리스트
    private func makeListSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection{
        let spacing: CGFloat = 10
        
        // 컬렉션 뷰가 들어갈 사이즈 구하기
        let containerSize = environment.container.effectiveContentSize
        let itemWidthSize = (containerSize.width - spacing * 2)
        
        // 가로폭만 계산해서 아이템 사이즈 계산
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidthSize),
            heightDimension: .absolute(90)
        )
        
        // 아이템 사이즈 지정
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 2번 쌓기
        let gridGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidthSize),
                heightDimension: .absolute(180)
            ),
            repeatingSubitem: item,
            count: 2
        )
        
        gridGroup.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: gridGroup)
        section.interGroupSpacing = spacing
        
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        section.boundarySupplementaryItems = [makeHeaderItem(height: 60)]
        return section
    }
    
    private func makeBookingSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection{
        let spacing: CGFloat = 10
        
        // 컬렉션 뷰가 들어갈 사이즈 구하기
        let containerSize = environment.container.effectiveContentSize
        let itemWidthSize = (containerSize.width - spacing * 2)
        
        // 가로폭만 계산해서 아이템 사이즈 계산
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidthSize),
            heightDimension: .absolute(90)
        )
        
        // 아이템 사이즈 지정
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 2번 쌓기
        let gridGroup = NSCollectionLayoutGroup.vertical(
            layoutSize:NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidthSize),
                heightDimension: .absolute(90)
            ),
            repeatingSubitem: item,
            count: 1
        )
        
        gridGroup.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: gridGroup)
        section.interGroupSpacing = spacing
        
        section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return section
    }
    
    private func makeHeaderItem(height: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(height)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
