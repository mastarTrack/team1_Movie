//
//  SearchView.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let tableView = SearchTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    private func setAttributes() {
        tableView.separatorStyle = .none
    }
    private func setLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
