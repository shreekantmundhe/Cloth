//
//  BasketViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


class BasketViewController: UIViewController {
    
    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var checkoutButton: UIButton!
    
    //Variables

    var addToCartProduct : [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        checkoutButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
 
    }

    override func viewDidAppear(_ animated: Bool) {
        let tabBar = tabBarController as! TabBarController
        addToCartProduct = tabBar.addToCartItem
        self.tableView.reloadData()
    }
}

extension BasketViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction.init(style:.destructive, title: "Remove", handler: { (action, view, completion) in
            self.addToCartProduct.remove(at: indexPath.row)
            let tabBar = self.tabBarController as! TabBarController
            tabBar.addToCartItem = self.addToCartProduct
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
            Haptic.feedBack()
        })
        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config

    }
}

extension BasketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return addToCartProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as? BasketViewTableViewCell else { fatalError("xib does not exists") }
        noProductsLabel.isHidden = true
        
        let product = addToCartProduct[indexPath.row]
          
        cell.configureWithProduct(product: product)
        //cell.productPrice.text = "1010"
       // let product = products[indexPath.row]
        //cell.configureWithProduct(product: product)
        return cell
    }
}

