//
//  ViewController.swift
//  GourmetApp
//
//  Created by 海野 颯汰   on 2024/08/29.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 検索一覧追加
        let searchResultVC = UINavigationController(rootViewController: SearchResultController())
        searchResultVC.tabBarItem = UITabBarItem(title: "検索一覧", image: UIImage(systemName: "list.bullet.rectangle.portrait"), tag: 0)
        
        // お気に入り追加
        let favoriteVC = UINavigationController(rootViewController: FavoriteCollectionViewController())
        favoriteVC.tabBarItem = UITabBarItem(title: "お気に入り", image: UIImage(systemName: "star"), tag: 1)
        
        viewControllers = [searchResultVC, favoriteVC]
    }
}

