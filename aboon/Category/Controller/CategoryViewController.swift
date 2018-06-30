//
//  CategoryViewController.swift
//  aboon
//
//  Created by 原口和音 on 2018/06/23.
//  Copyright © 2018 aboon. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let model = CategoryCollectionModel()
    
    override func loadView() {
        let categoryView = CategoryView()
        self.view = categoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.configureBarItems(title: "カテゴリー", navigationController: navigationController as! NavigationController)
        (self.view as! CategoryView).setFrame(tabBar: (tabBarController?.tabBar)!, navBar: navigationController?.navigationBar as! NavigationBar)
        (self.view as! CategoryView).appendActivityIndicator()
       
        model.fetchCategories()
        model.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension CategoryViewController: CategoryCollectionModelDelegate {
    func dataDidLoad() {
        let categoryCollectionView = (self.view as! CategoryView).initializeCollectionView(numberOfCells: model.categories.count)
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = model
        (self.view as! CategoryView).appendCollectionView(collectionView: categoryCollectionView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let couponListViewController = CouponListViewController(withTitle: model.categoryNames[indexPath.row])
        couponListViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(couponListViewController, animated: true)
    }
}

