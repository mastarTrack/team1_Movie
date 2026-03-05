//
//  ReservationViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReservationViewController: UIViewController {
    
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

extension ReservationViewController {
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

extension ReservationViewController {
    private func setDelegate() {
        reservationView.collectionView.delegate = self
        reservationView.collectionView.dataSource = self
    }
}

extension ReservationViewController {
    func loadData() {
        viewModel.loadData()
    }
}

extension ReservationViewController: UICollectionViewDelegate{
    
}
extension ReservationViewController: UICollectionViewDataSource{
    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReservationCollectionViewCell.id, for: indexPath) as? ReservationCollectionViewCell else { return UICollectionViewCell() }
        
        let data = viewModel.getData(section: indexPath.section, item: indexPath.item)
        cell.config(data: data)
        return cell
    }
}
