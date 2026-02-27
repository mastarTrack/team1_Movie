//
//  SearchView.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let searchBar = UISearchBar()
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
        
        searchBar.placeholder = "영화 검색"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .systemGray6
        
        
        tableView.separatorStyle = .none
    }
    private func setLayout() {
        [searchBar, tableView].forEach { addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
