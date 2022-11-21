//
//  TabBarController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//
import UIKit

protocol WhishListProducts: class {
    func setWishListProduct(_ product: Product)
}

protocol AddToCartProducts: class {
    func setAddToCartProduct(_ product: Product)
}

class TabBarController: UITabBarController, WhishListProducts, AddToCartProducts {
    var wishListItem : [Product] = []
    var addToCartItem : [Product] = []
    var allItems : [Product] = []
    
    func setWishListProduct(_ product: Product) {        
        wishListItem = wishListItem.filter({$0.productId != product.productId})
        wishListItem.append(product)
    }
    
    func setAddToCartProduct(_ product: Product) {
        allItems = allItems.map{
            var item = $0
            guard item.productId == product.productId,
                var stock = item.stock,
                stock >= 1  else {
              return item
            }
            stock -= 1
            item.stock = stock
            return item
        }
        
        var product1 = product
        
        guard let stock = product1.stock,
              stock >= 1 else {
            return
        }
        
        if !addToCartItem.contains(where: { $0.productId == product1.productId}) {
            product1.stock = 1
            addToCartItem.append(product1)
        } else {
            addToCartItem = addToCartItem.map{
                var mutableItem = $0
                if $0.productId == product1.productId {
                    mutableItem.stock! += 1
                }
                return mutableItem
            }
        }
        
//        let productdetailsVC = self.storyboard?.instantiateViewController(withIdentifier: Identifier.detailContainer()) as! ProductDetailTableViewController
//        productdetailsVC.tableView.reloadData()
    }
    
    func updateAddToCartItems() {
        
    }

    //Views
    var tabItem : UITabBarItem?

    //Variables
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let tabItems = tabBar.items {
            tabItem = tabItems[2]
        }

    }
}
