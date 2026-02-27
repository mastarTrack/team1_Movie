//
//  SearchViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
