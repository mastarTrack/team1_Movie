//
//  ReservationDetailViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReservationDetailViewController: UIViewController {
    
    private let reservationView = ReservationCollectionView()
    private let viewModel = ReservationViewModel()
    
    override func loadView() {
        self.view = reservationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        bind()
        loadData()
    }
}

extension ReservationDetailViewController {
    private func bind() {
        viewModel.onUpdated = { [weak self] in
            guard let self = self else { return }
            
            if viewModel.isEmpty {
                let emptyLabel = UILabel()
                emptyLabel.text = "예매 내역이 없습니다."
                emptyLabel.textColor = .systemGray
                emptyLabel.textAlignment = .center
                reservationView.collectionView.backgroundView = emptyLabel
            } else {
                reservationView.collectionView.backgroundView = nil
            }
            reservationView.collectionView.reloadData()
        }
    }
}

extension ReservationDetailViewController {
    private func setDelegate() {
        reservationView.collectionView.delegate = self
        reservationView.collectionView.dataSource = self
    }
}

extension ReservationDetailViewController {
    func loadData() {
        viewModel.loadData()
    }
}

extension ReservationDetailViewController: UICollectionViewDelegate{
    
}
extension ReservationDetailViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReservationHeaderView.id, for: indexPath) as? ReservationHeaderView else { return UICollectionReusableView() }
        
        header.config(title: viewModel.setHeaderTitle(section: indexPath.section))
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReservationDetailCell.id, for: indexPath) as? ReservationDetailCell else { return UICollectionViewCell() }
        
        let data = viewModel.getData(section: indexPath.section, item: indexPath.item)
        cell.config(data: data)
        return cell
    }
}
