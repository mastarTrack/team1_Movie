//
//  MainTabBarController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
    }
}

extension TabBarController {
    private func setupTabBar() {
        let homeVC = createNC(rootVC: ViewController(), title: "Home", image: "house.fill")
        let searchVC = createNC(rootVC: SearchViewController(), title: "Search", image: "magnifyingglass")
        tabBar.tintColor = .systemOrange
        tabBar.unselectedItemTintColor = .systemGray5
        viewControllers = [homeVC, searchVC]
    }
    
    private func createNC(rootVC: UIViewController, title: String, image: String) -> UINavigationController {
        let nc = UINavigationController(rootViewController: rootVC)
        nc.tabBarItem.title = title
        nc.tabBarItem.image = UIImage(systemName: image)
        return nc
    }
}
